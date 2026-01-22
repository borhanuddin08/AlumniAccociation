<?php
$pageTitle = 'Student Management';
require_once __DIR__ . '/../includes/admin_header.php';

$db = getDB();

// Handle actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['approve_user'])) {
        $userId = (int)$_POST['user_id'];
        
        // Fetch user details for email
        $stmt = $db->prepare("SELECT name, email FROM users WHERE id = ?");
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        $user = $stmt->get_result()->fetch_assoc();
        
        $stmt = $db->prepare("UPDATE users SET status = 'active' WHERE id = ?");
        $stmt->bind_param("i", $userId);
        if ($stmt->execute()) {
            // Send Approval Email
            if ($user) {
                $subject = "Account Approved - " . SITE_NAME;
                $message = "<h2>Congratulations! Your Account is Approved</h2>";
                $message .= "<p>Hello <strong>{$user['name']}</strong>,</p>";
                $message .= "<p>We are pleased to inform you that your registration for " . SITE_NAME . " has been accepted.</p>";
                $message .= "<p>You can now log in to your account.</p>";
                $message .= "<p><a href='" . SITE_URL . "/auth/login.php' style='background-color:#FF6622; color:white; padding:10px 20px; text-decoration:none; border-radius:5px;'>Login Now</a></p>";
                
                sendEmail($user['email'], $subject, $message);
            }
            
            redirectWithMessage(SITE_URL . '/admin/students.php', 'Student approved successfully!', 'success');
        }
    } elseif (isset($_POST['block_user'])) {
        $userId = (int)$_POST['user_id'];
        
        // Fetch user details for email
        $stmt = $db->prepare("SELECT name, email FROM users WHERE id = ?");
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        $user = $stmt->get_result()->fetch_assoc();
        
        $stmt = $db->prepare("UPDATE users SET status = 'blocked' WHERE id = ?");
        $stmt->bind_param("i", $userId);
        if ($stmt->execute()) {
            // Send Blocked Email
            if ($user) {
                $subject = "Account Warning - " . SITE_NAME;
                $message = "<h2>Account Suspended</h2>";
                $message .= "<p>Hello <strong>{$user['name']}</strong>,</p>";
                $message .= "<p>Your account on " . SITE_NAME . " has been suspended/blocked by the administrator.</p>";
                $message .= "<p>If you believe this is a mistake, please contact the support team.</p>";
                
                sendEmail($user['email'], $subject, $message);
            }

            redirectWithMessage(SITE_URL . '/admin/students.php', 'Student blocked successfully!', 'success');
        }
    } elseif (isset($_POST['delete_user'])) {
        $userId = (int)$_POST['user_id'];
        
        // Fetch user details for email
        $stmt = $db->prepare("SELECT name, email FROM users WHERE id = ?");
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        $user = $stmt->get_result()->fetch_assoc();
        
        $stmt = $db->prepare("DELETE FROM users WHERE id = ?");
        $stmt->bind_param("i", $userId);
        if ($stmt->execute()) {
             // Send Deletion Email
            if ($user) {
                $subject = "Account Deleted - " . SITE_NAME;
                $message = "<h2>Account Deleted</h2>";
                $message .= "<p>Hello <strong>{$user['name']}</strong>,</p>";
                $message .= "<p>Your account on " . SITE_NAME . " has been permanently deleted/rejected.</p>";
                
                sendEmail($user['email'], $subject, $message);
            }
            
            redirectWithMessage(SITE_URL . '/admin/students.php', 'Student deleted successfully!', 'success');
        }
    }
}

// Get filters
$statusFilter = $_GET['status'] ?? '';
$deptFilter = $_GET['department'] ?? '';
$searchQuery = $_GET['search'] ?? '';

// Start with role = student
$conditions = ["role = 'student'"];
$params = [];
$types = '';

if (!empty($statusFilter)) {
    $conditions[] = "status = ?";
    $params[] = $statusFilter;
    $types .= 's';
}

if (!empty($deptFilter)) {
    $conditions[] = "department = ?";
    $params[] = $deptFilter;
    $types .= 's';
}



if (!empty($searchQuery)) {
    $conditions[] = "(name LIKE ? OR email LIKE ? OR department LIKE ?)";
    $searchParam = "%$searchQuery%";
    $params[] = $searchParam;
    $params[] = $searchParam;
    $params[] = $searchParam;
    $types .= 'sss';
}

$whereClause = implode(' AND ', $conditions);
$query = "SELECT * FROM users WHERE $whereClause ORDER BY created_at DESC";

$stmt = $db->prepare($query);
if (!empty($params)) {
    $stmt->bind_param($types, ...$params);
}
$stmt->execute();
$students = $stmt->get_result();

// Get unique departments for filter dropdown
$deptResult = $db->query("SELECT DISTINCT department FROM users WHERE department IS NOT NULL AND department != '' ORDER BY department");
$departments = [];
while ($row = $deptResult->fetch_assoc()) {
    $departments[] = $row['department'];
}
?>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="mb-0">
            <i class="fas fa-user-graduate me-2 text-primary"></i>Student Management
        </h4>
    </div>
    
    <!-- Filters -->
    <div class="card mb-4">
        <div class="card-body">
            <form method="GET" action="" class="row g-3">
                <div class="col-md-3">
                    <input type="text" class="form-control" name="search" 
                           value="<?php echo htmlspecialchars($searchQuery); ?>" 
                           placeholder="Search students...">
                </div>
                <div class="col-md-2">
                    <select class="form-select" name="department">
                        <option value="">All Depts</option>
                        <?php foreach ($departments as $dept): ?>
                            <option value="<?php echo htmlspecialchars($dept); ?>" 
                                <?php echo $deptFilter === $dept ? 'selected' : ''; ?>>
                                <?php echo htmlspecialchars($dept); ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="col-md-2">
                    <select class="form-select" name="status">
                        <option value="">All Status</option>
                        <option value="pending" <?php echo $statusFilter === 'pending' ? 'selected' : ''; ?>>Pending</option>
                        <option value="active" <?php echo $statusFilter === 'active' ? 'selected' : ''; ?>>Active</option>
                        <option value="blocked" <?php echo $statusFilter === 'blocked' ? 'selected' : ''; ?>>Blocked</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-search me-1"></i>Filter
                    </button>
                </div>
                <div class="col-md-1">
                    <a href="<?php echo SITE_URL; ?>/admin/students.php" class="btn btn-outline-secondary w-100" title="Reset">
                        <i class="fas fa-redo"></i>
                    </a>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Students Table -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Department</th>
                            <th>ID Card</th>
                            <th>Status</th>
                            <th>Registered</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if ($students->num_rows > 0): ?>
                            <?php while ($student = $students->fetch_assoc()): ?>
                                <tr>
                                    <td><?php echo $student['id']; ?></td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="<?php echo SITE_URL . '/uploads/' . $student['profile_image']; ?>" 
                                                 class="rounded-circle me-2" 
                                                 style="width: 30px; height: 30px; object-fit: cover;"
                                                 alt="<?php echo htmlspecialchars($student['name']); ?>">
                                            <?php echo htmlspecialchars($student['name']); ?>
                                        </div>
                                    </td>
                                    <td><?php echo htmlspecialchars($student['email']); ?></td>
                                    <td><?php echo htmlspecialchars($student['department']); ?></td>
                                    <td>
                                        <?php if (!empty($student['id_card_image'])): ?>
                                            <a href="<?php echo SITE_URL . '/uploads/' . $student['id_card_image']; ?>" 
                                               target="_blank" class="btn btn-sm btn-info">
                                                <i class="fas fa-id-card me-1"></i>View ID
                                            </a>
                                        <?php else: ?>
                                            <span class="text-muted small">Not uploaded</span>
                                        <?php endif; ?>
                                    </td>
                                    <td>
                                        <span class="badge bg-<?php 
                                            echo $student['status'] === 'active' ? 'success' : 
                                                ($student['status'] === 'pending' ? 'warning' : 'danger'); 
                                        ?>">
                                            <?php echo ucfirst($student['status']); ?>
                                        </span>
                                    </td>
                                    <td><?php echo date('M d, Y', strtotime($student['created_at'])); ?></td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <?php if ($student['status'] === 'pending'): ?>
                                                <form method="POST" style="display: inline;">
                                                    <input type="hidden" name="user_id" value="<?php echo $student['id']; ?>">
                                                    <button type="submit" name="approve_user" class="btn btn-success btn-sm" 
                                                            onclick="return confirm('Approve this student?')">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </form>
                                            <?php endif; ?>
                                            
                                            <?php if ($student['status'] !== 'blocked'): ?>
                                                <form method="POST" style="display: inline;">
                                                    <input type="hidden" name="user_id" value="<?php echo $student['id']; ?>">
                                                    <button type="submit" name="block_user" class="btn btn-warning btn-sm" 
                                                            onclick="return confirm('Block this student?')">
                                                        <i class="fas fa-ban"></i>
                                                    </button>
                                                </form>
                                            <?php endif; ?>
                                            
                                            <form method="POST" style="display: inline;">
                                                <input type="hidden" name="user_id" value="<?php echo $student['id']; ?>">
                                                <button type="submit" name="delete_user" class="btn btn-danger btn-sm" 
                                                        onclick="return confirm('Delete this student permanently?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            <?php endwhile; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="8" class="text-center py-4">
                                    <div class="text-muted">
                                        <i class="fas fa-user-graduate fa-3x mb-3 d-block"></i>
                                        No students found
                                    </div>
                                </td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<?php require_once __DIR__ . '/../includes/admin_footer.php'; ?>
