<?php
// Output buffering to prevent headers already sent errors
ob_start();

require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/sslcommerz_config.php';
require_once __DIR__ . '/../includes/functions.php';
require_once __DIR__ . '/../includes/db_connect.php';

startSession();
requireLogin();

// Suppress display errors for this script to ensure JSON/Redirection works
// Log errors to file instead
ini_set('display_errors', 0);
ini_set('log_errors', 1);
error_reporting(E_ALL);

// Explicit debug log file
define('DEBUG_LOG_FILE', __DIR__ . '/../debug_payment.log');
function paymentLog($message) {
    error_log("[" . date('Y-m-d H:i:s') . "] " . $message . "\n", 3, DEBUG_LOG_FILE);
}

paymentLog("Payment initialization started by user");

$user = getCurrentUser();
$db = getDB();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    ob_end_clean(); // Clean buffer before redirect
    redirectWithMessage(SITE_URL . '/user/donations.php', 'Invalid request', 'error');
}

$fundraiserId = (int)$_POST['fundraiser_id'];
$amount = (float)$_POST['amount'];

if ($amount < 10) {
    ob_end_clean();
    redirectWithMessage(SITE_URL . '/user/donations.php', 'Minimum donation amount is BDT 10', 'warning');
}

// Get fundraiser details
$stmt = $db->prepare("SELECT * FROM fundraisers WHERE id = ? AND status = 'active'");
$stmt->bind_param("i", $fundraiserId);
$stmt->execute();
$fundraiser = $stmt->get_result()->fetch_assoc();

if (!$fundraiser) {
    ob_end_clean();
    redirectWithMessage(SITE_URL . '/user/donations.php', 'Invalid fundraiser', 'error');
}

// Generate unique transaction ID
$tran_id = 'DON' . time() . rand(1000, 9999);

// Insert pending donation record
$stmt = $db->prepare("INSERT INTO donations (fundraiser_id, user_id, amount, transaction_id, payment_method, status) VALUES (?, ?, ?, ?, 'sslcommerz', 'Pending')");
$stmt->bind_param("iids", $fundraiserId, $user['id'], $amount, $tran_id);

if (!$stmt->execute()) {
    ob_end_clean();
    redirectWithMessage(SITE_URL . '/user/donations.php', 'Failed to process donation', 'error');
}

// Prepare SSLCommerz payment data
$post_data = array();
$post_data['store_id'] = SSLCZ_STORE_ID;
$post_data['store_passwd'] = SSLCZ_STORE_PASSWORD;
$post_data['total_amount'] = $amount;
$post_data['currency'] = 'BDT';
$post_data['tran_id'] = $tran_id;
$post_data['success_url'] = SSLCZ_SUCCESS_URL;
$post_data['fail_url'] = SSLCZ_FAIL_URL;
$post_data['cancel_url'] = SSLCZ_CANCEL_URL;
$post_data['ipn_url'] = SSLCZ_IPN_URL;

// Customer information
$post_data['cus_name'] = $user['name'];
$post_data['cus_email'] = $user['email'];
$post_data['cus_add1'] = $user['location'] ?? 'Dhaka';
$post_data['cus_city'] = 'Dhaka';
$post_data['cus_country'] = 'Bangladesh';
$post_data['cus_phone'] = $user['phone'] ?? '01700000000';

// Product information
$post_data['product_name'] = 'Donation: ' . $fundraiser['title'];
$post_data['product_category'] = 'Donation';
$post_data['product_profile'] = 'non-physical-goods';

// Shipping information (required but not used for donations)
$post_data['shipping_method'] = 'NO';
$post_data['num_of_item'] = 1;

// Initialize cURL
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, SSLCZ_API_URL);
curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // For local testing

$response = curl_exec($ch);
$curl_error = curl_error($ch);
curl_close($ch);

// Log response for debugging
if (ini_get('log_errors')) {
    paymentLog("SSLCommerz API URL: " . SSLCZ_API_URL);
    paymentLog("SSLCommerz Request: " . json_encode($post_data));
    paymentLog("SSLCommerz Response: " . $response);
    paymentLog("SSLCommerz Curl Error: " . $curl_error);
}

if ($curl_error) {
    // Update donation status to Failed
    $stmt = $db->prepare("UPDATE donations SET status = 'Failed' WHERE transaction_id = ?");
    $stmt->bind_param("s", $tran_id);
    $stmt->execute();
    
    ob_end_clean();
    redirectWithMessage(SITE_URL . '/user/donations.php', 'Payment gateway error: ' . $curl_error, 'error');
}

$response_data = json_decode($response, true);

if (isset($response_data['status']) && $response_data['status'] === 'SUCCESS') {
    // Redirect to payment gateway
    ob_end_clean(); // Clean buffer to ensure no output before header
    header('Location: ' . $response_data['GatewayPageURL']);
    exit;
} else {
    // Update donation status to Failed
    $stmt = $db->prepare("UPDATE donations SET status = 'Failed' WHERE transaction_id = ?");
    $stmt->bind_param("s", $tran_id);
    $stmt->execute();
    
    $error_msg = $response_data['failedreason'] ?? 'Unknown error';
    
    // Log extended error info
    paymentLog("SSLCommerz Failed Reason: " . $error_msg);
    if (!empty($response_data['error'])) {
        paymentLog("SSLCommerz Error Data: " . $response_data['error']);
    }
    
    ob_end_clean();
    redirectWithMessage(SITE_URL . '/user/donations.php', 'Payment initialization failed: ' . $error_msg, 'error');
}
?>
