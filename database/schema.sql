-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 21, 2026 at 07:10 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uiu_alumni_connect`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'admin', 'admin@uiu.ac.bd', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2025-11-02 07:13:06');

-- --------------------------------------------------------

--
-- Table structure for table `batches`
--

CREATE TABLE `batches` (
  `id` int(11) NOT NULL,
  `batch_name` varchar(50) NOT NULL,
  `department` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `batches`
--

INSERT INTO `batches` (`id`, `batch_name`, `department`, `description`, `created_at`) VALUES
(1, 'CSE 181', 'Computer Science & Engineering', 'CSE Spring 2018 Batch', '2025-11-02 07:13:06'),
(2, 'CSE 182', 'Computer Science & Engineering', 'CSE Summer 2018 Batch', '2025-11-02 07:13:06'),
(3, 'CSE 191', 'Computer Science & Engineering', 'CSE Spring 2019 Batch', '2025-11-02 07:13:06'),
(4, 'CSE 192', 'Computer Science & Engineering', 'CSE Summer 2019 Batch', '2025-11-02 07:13:06'),
(5, 'BBA 171', 'Business Administration', 'BBA Spring 2017 Batch', '2025-11-02 07:13:06'),
(6, 'BBA 181', 'Business Administration', 'BBA Spring 2018 Batch', '2025-11-02 07:13:06'),
(7, 'EEE 181', 'Electrical & Electronic Engineering', 'EEE Spring 2018 Batch', '2025-11-02 07:13:06'),
(8, 'CE 181', 'Civil Engineering', 'CE Spring 2018 Batch', '2025-11-02 07:13:06');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `post_id`, `user_id`, `comment_text`, `created_at`) VALUES
(1, 3, 5, 'good and you', '2025-11-16 16:07:16'),
(2, 8, 22, 'how', '2026-01-20 21:26:17');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `created_at`) VALUES
(1, 'Department of Pharmacy', '2026-01-20 20:07:20');

-- --------------------------------------------------------

--
-- Table structure for table `donations`
--

CREATE TABLE `donations` (
  `id` int(11) NOT NULL,
  `fundraiser_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT 'card',
  `status` enum('Pending','Processing','Success','Failed','Cancelled') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `donations`
--

INSERT INTO `donations` (`id`, `fundraiser_id`, `user_id`, `amount`, `transaction_id`, `payment_method`, `status`, `created_at`) VALUES
(1, 1, 7, 500.00, 'TRX-694FCE023CE48', 'bkash', 'Pending', '2025-12-27 12:16:02'),
(2, 1, 10, 10.00, 'DON17668383715606', 'SSLCommerz (BKASH-BKash)', 'Success', '2025-12-27 12:26:11'),
(3, 1, 6, 600.00, 'DON17681956614442', 'SSLCommerz (BKASH-BKash)', 'Success', '2026-01-12 05:27:41'),
(4, 1, 6, 600.00, 'DON17689410965282', 'sslcommerz', 'Pending', '2026-01-20 20:31:36'),
(5, 1, 6, 5000.00, 'DON17689411252561', 'sslcommerz', 'Pending', '2026-01-20 20:32:05'),
(6, 1, 6, 500.00, 'DON17689417499881', 'Simulated/Manual', 'Success', '2026-01-20 20:42:29'),
(7, 1, 6, 800.00, 'DON17689419437344', 'sslcommerz', 'Pending', '2026-01-20 20:45:43'),
(8, 1, 6, 500.00, 'DON17689423632342', 'sslcommerz', 'Pending', '2026-01-20 20:52:43'),
(9, 1, 6, 900.00, 'DON17689696608103', 'sslcommerz', 'Pending', '2026-01-21 04:27:40'),
(10, 1, 4, 700.00, 'DON17689698143801', 'SSLCommerz (BKASH-BKash)', 'Success', '2026-01-21 04:30:14');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `event_date` datetime NOT NULL,
  `venue` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `event_date`, `venue`, `created_by`, `is_featured`, `created_at`) VALUES
(1, 'Pitha mela', 'fghjkl;\'', '2026-01-21 02:02:00', 'uiu math', 1, 1, '2026-01-20 20:02:37');

-- --------------------------------------------------------

--
-- Table structure for table `event_participants`
--

CREATE TABLE `event_participants` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('going','interested') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('new','read','replied') DEFAULT 'new',
  `admin_reply` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fundraisers`
--

CREATE TABLE `fundraisers` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `goal_amount` decimal(10,2) NOT NULL,
  `current_amount` decimal(10,2) DEFAULT 0.00,
  `image_url` varchar(255) DEFAULT 'default-fundraiser.jpg',
  `status` enum('active','completed','closed') DEFAULT 'active',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fundraisers`
--

INSERT INTO `fundraisers` (`id`, `title`, `description`, `goal_amount`, `current_amount`, `image_url`, `status`, `created_by`, `created_at`, `end_date`) VALUES
(1, 'Scholarship Fund 2024', 'Touching lives, one scholarship at a time. Help us support meritorious but needy students of UIU.', 500000.00, 2310.00, 'default-fundraiser.jpg', 'active', 1, '2025-12-27 12:13:19', '2026-01-26 18:13:19');

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `caption` text DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `batch` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `event_type` enum('reunion','campus','event','achievement','other') DEFAULT 'other',
  `likes_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `user_id`, `image_url`, `caption`, `tags`, `batch`, `department`, `event_type`, `likes_count`, `created_at`) VALUES
(1, 10, '694fd18b53cca_1766838667.jpg', 'eid mubarak', '#eiid2026', 'CSE 192', 'Computer Science & Engineering', 'event', 2, '2025-12-27 12:31:07');

-- --------------------------------------------------------

--
-- Table structure for table `gallery_likes`
--

CREATE TABLE `gallery_likes` (
  `id` int(11) NOT NULL,
  `gallery_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gallery_likes`
--

INSERT INTO `gallery_likes` (`id`, `gallery_id`, `user_id`, `created_at`) VALUES
(1, 1, 10, '2025-12-27 12:31:16'),
(3, 1, 4, '2026-01-21 04:30:59');

-- --------------------------------------------------------

--
-- Table structure for table `group_messages`
--

CREATE TABLE `group_messages` (
  `id` int(11) NOT NULL,
  `group_type` enum('department','batch') NOT NULL,
  `group_value` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `group_messages`
--

INSERT INTO `group_messages` (`id`, `group_type`, `group_value`, `user_id`, `message`, `created_at`) VALUES
(1, 'department', 'Computer Science & Engineering', 10, '@Molla Omar', '2025-12-27 11:22:08'),
(2, 'department', 'Computer Science & Engineering', 10, '@Molla Omar', '2025-12-27 11:22:18'),
(3, 'batch', 'CSE 191', 4, 'hi', '2026-01-20 19:46:36');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `company` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `job_type` enum('full-time','part-time','internship','contract') DEFAULT 'full-time',
  `salary_range` varchar(100) DEFAULT NULL,
  `posted_by` int(11) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `title`, `description`, `company`, `location`, `job_type`, `salary_range`, `posted_by`, `status`, `created_at`, `expires_at`) VALUES
(1, 'Need a fronted designer', 'dj mc djkc cksdj', 'ATC', 'Dhak', 'part-time', '10-20k', 10, 'approved', '2025-12-27 11:20:10', NULL),
(2, 'Project Manager', 'need a project manager for my company with experience of 4 years', 'omar tech', 'badda,dhaka', 'full-time', '20k', 4, 'approved', '2026-01-12 06:08:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `post_id`, `user_id`, `created_at`) VALUES
(1, 3, 5, '2025-11-16 16:07:06'),
(2, 3, 4, '2025-11-29 10:00:54'),
(3, 3, 7, '2025-12-27 10:39:02'),
(4, 5, 6, '2026-01-20 18:43:22'),
(5, 8, 22, '2026-01-20 21:26:12'),
(6, 8, 4, '2026-01-21 05:42:13');

-- --------------------------------------------------------

--
-- Table structure for table `mentorship_requests`
--

CREATE TABLE `mentorship_requests` (
  `id` int(11) NOT NULL,
  `mentor_id` int(11) NOT NULL,
  `mentee_id` int(11) NOT NULL,
  `status` enum('pending','accepted','rejected') DEFAULT 'pending',
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mentorship_requests`
--

INSERT INTO `mentorship_requests` (`id`, `mentor_id`, `mentee_id`, `status`, `message`, `created_at`, `updated_at`) VALUES
(1, 10, 7, 'accepted', 'I need your mentorship', '2025-12-27 11:56:41', '2025-12-27 12:03:14'),
(2, 1, 2, 'pending', 'Test Request from Script', '2025-12-27 12:00:54', '2025-12-27 12:00:54'),
(3, 4, 6, 'pending', 'dfgh', '2026-01-21 05:48:47', '2026-01-21 05:48:47');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `message`, `is_read`, `created_at`) VALUES
(1, 4, 1, 'hi', 1, '2025-11-02 07:29:54'),
(2, 1, 4, 'hlww', 1, '2025-11-02 07:30:59'),
(3, 7, 5, 'hi', 0, '2025-12-27 10:59:35'),
(4, 7, 10, 'hi sir', 1, '2025-12-27 12:06:26'),
(5, 10, 7, 'hello', 1, '2025-12-27 12:10:20'),
(6, 6, 4, 'hi', 1, '2026-01-20 20:54:44'),
(7, 6, 13, 'hi', 0, '2026-01-20 20:55:51'),
(8, 6, 4, 'sir', 1, '2026-01-20 21:05:16'),
(9, 22, 16, 'hii', 0, '2026-01-20 21:26:42'),
(10, 4, 6, 'yeah', 0, '2026-01-21 04:31:17');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `reference_id`, `message`, `is_read`, `created_at`) VALUES
(1, 1, 'message', 4, 'New message from Molla Omar', 0, '2025-11-02 07:29:54'),
(2, 4, 'message', 1, 'New message from Rakib Hasan', 0, '2025-11-02 07:30:59'),
(3, 4, 'like', 3, 'IHAM ARAF liked your post', 0, '2025-11-16 16:07:06'),
(4, 4, 'comment', 3, 'IHAM ARAF commented on your post', 0, '2025-11-16 16:07:16'),
(5, 4, 'like', 3, 'Md Borhan Uddin liked your post', 0, '2025-12-27 10:39:02'),
(6, 5, 'message', 7, 'New message from Md Borhan Uddin', 0, '2025-12-27 10:59:35'),
(7, 4, 'mention', 1, 'You were mentioned in a chat by mmm', 0, '2025-12-27 11:22:08'),
(8, 4, 'mention', 2, 'You were mentioned in a chat by mmm', 0, '2025-12-27 11:22:18'),
(9, 10, 'message', 7, 'New message from Md Borhan Uddin', 0, '2025-12-27 12:06:26'),
(10, 7, 'message', 10, 'New message from mmm', 0, '2025-12-27 12:10:20'),
(11, 10, 'donation', 1, 'Your donation of BDT 10 was successful!', 0, '2025-12-27 12:26:37'),
(12, 6, 'donation', 1, 'Your donation of BDT 600 was successful!', 0, '2026-01-12 05:28:09'),
(13, 6, 'donation', 1, 'Thank you! Your donation of BDT 500 was successful.', 0, '2026-01-20 20:42:29'),
(14, 4, 'message', 6, 'New message from M Zihad', 0, '2026-01-20 20:54:44'),
(15, 13, 'message', 6, 'New message from M Zihad', 0, '2026-01-20 20:55:51'),
(16, 4, 'message', 6, 'New message from M Zihad', 0, '2026-01-20 21:05:16'),
(17, 4, 'like', 8, 'Md Mottasim Leemon liked your post', 0, '2026-01-20 21:26:12'),
(18, 4, 'comment', 8, 'Md Mottasim Leemon commented on your post', 0, '2026-01-20 21:26:17'),
(19, 16, 'message', 22, 'New message from Md Mottasim Leemon', 0, '2026-01-20 21:26:42'),
(20, 4, 'donation', 1, 'Your donation of BDT 700 was successful!', 0, '2026-01-21 04:30:39'),
(21, 6, 'message', 4, 'New message from Molla Omar', 0, '2026-01-21 04:31:17');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `expires_at`, `created_at`) VALUES
(1, 'mzihad@gmail.com', 'e70d5144d3826b2e3e1b8db2f69b212b48e02d69b97a0e60537e5cff0402fe95', '2025-12-27 16:26:37', '2025-12-27 15:26:37'),
(3, 'omar123@gmail.com', 'e4b977041815d4ffd87f1ac369ef27766d33b8ac459fd7b3c83d7f6e1410c626', '2025-12-27 16:39:24', '2025-12-27 15:39:24'),
(8, 'mollaomar991@gmail.com', 'fedcdfe39f70d1c8a7f5b3829cda4cab574b5eddcc7cc7a64ae8c38699138007', '2026-01-11 19:58:10', '2026-01-11 18:58:10'),
(9, 'mollaomar9022@gmail.com', 'e9f84bb5fe89eedcf4a648a4426a61fed62e1a3857a3c577675f682dce3c165a', '2026-01-12 06:29:28', '2026-01-12 05:29:28'),
(10, 'omarmolla9022@gmail.com', '68caef48579ed97e2c2fcfcbd22abb56a0315746f3bfde51d0d09c226f907c78', '2026-01-12 09:50:02', '2026-01-12 09:40:02');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL,
  `visibility` enum('public','batch','department') DEFAULT 'public',
  `is_pinned` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `content`, `image`, `link`, `visibility`, `is_pinned`, `created_at`, `updated_at`) VALUES
(1, 1, 'hi..I am rakin', NULL, '', 'public', 0, '2025-11-02 07:16:55', '2025-11-02 07:16:55'),
(2, 1, 'hi..I am rakin', '690705ada7cee_1762067885.png', '', 'public', 0, '2025-11-02 07:18:05', '2025-11-02 07:18:05'),
(3, 4, 'hi guys hope you r all doing well ....', NULL, '', 'public', 0, '2025-11-16 15:57:22', '2025-11-16 15:57:22'),
(4, 14, 'jnjh', NULL, '', 'public', 0, '2026-01-11 19:57:47', '2026-01-11 19:57:47'),
(5, 6, 'scdfvbghnjmmhngbfv', '69648612d8acf_1768195602.png', '', 'public', 0, '2026-01-12 05:26:42', '2026-01-12 05:26:42'),
(6, 4, 'his', NULL, '', 'public', 0, '2026-01-20 19:35:58', '2026-01-20 19:35:58'),
(7, 4, 'hi', NULL, '', 'batch', 0, '2026-01-20 19:36:05', '2026-01-20 19:36:05'),
(8, 4, 'hi', NULL, '', 'department', 0, '2026-01-20 19:36:16', '2026-01-20 19:36:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `batch` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `education` text DEFAULT NULL,
  `work_experience` text DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT 'default-avatar.png',
  `bio` text DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `role` enum('student','alumni') NOT NULL DEFAULT 'student',
  `id_card_image` varchar(255) DEFAULT NULL,
  `status` enum('pending','active','blocked') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `batch`, `department`, `education`, `work_experience`, `profile_image`, `bio`, `skills`, `phone`, `location`, `linkedin`, `role`, `id_card_image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Rakib Hasan', 'rakib@uiu.ac.bd', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'CSE 181', 'Computer Science & Engineering', 'BSc in CSE from UIU', 'Software Engineer at Google', '690706e1537ac_1762068193.png', '', NULL, '', '', '', 'alumni', NULL, 'active', '2025-11-02 07:13:06', '2026-01-12 05:58:15'),
(2, 'Tasnim Ahmed', 'tasnim@uiu.ac.bd', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'CSE 182', 'Computer Science & Engineering', 'BSc in CSE from UIU, MSc from MIT', 'Senior Developer at Microsoft', 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'alumni', NULL, 'active', '2025-11-02 07:13:06', '2026-01-12 05:58:15'),
(3, 'Fatema Begum', 'fatema@uiu.ac.bd', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'BBA 181', 'Business Administration', 'BBA from UIU, MBA from IBA', 'Marketing Manager at Unilever', 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'alumni', NULL, 'active', '2025-11-02 07:13:06', '2026-01-12 05:58:15'),
(4, 'Molla Omar', 'mollaomar@uiu.ac.bd', '$2y$10$icv8wGWZBv57l95ObcYOBeKSJXezdktPBIHOW5Jh44FylA1vt5Mpu', 'CSE 191', 'Computer Science & Engineering', 'primary school certificate 2013\r\njunior school certificate  2016\r\nSecondary School certificate  2019\r\nhigher School certificate 2021', 'NULL', '69070839717bf_1762068537.jpeg', 'I Omar 4th son of my father and doing undergraduate in cse at united international university.', NULL, '01922222222', 'Dhaka', 'https://www.linkedin.com/in/molla-omar-49b0481b8/', 'alumni', NULL, 'active', '2025-11-02 07:26:23', '2026-01-12 06:03:25'),
(5, 'IHAM ARAF', 'iham@gmail.com', '$2y$10$iC8S.lquqTwuxDdM7fE92eTqEeHNA9r4hzbQskGR3ZWGcK1Gn.uWq', 'CSE 181', 'Computer Science & Engineering', '', '', '6919f6746cf7b_1763309172.png', '', NULL, '', '', '', 'student', NULL, 'active', '2025-11-16 16:02:09', '2025-12-27 11:15:27'),
(6, 'M Zihad', 'mzihad@gmail.com', '$2y$10$k0AkXlSK6D7D9KYPUFe0K.IibNFQON3gYkbYVdXW4ZlNsETTmcfxy', 'CSE 192', 'Computer Science & Engineering', 'fords', 'vddv', '6951548bca188_1766937739.png', 'dssdv', 'dsf', '09876543', 'fvdfv', '', 'student', NULL, 'active', '2025-11-22 10:11:14', '2025-12-28 16:03:54'),
(7, 'Md Borhan Uddin', 'borhan@gmail.com', '$2y$10$T70bi/iAcUaOBEL.v1Gs7.9miGxOMiMSww4t.EgjYNSfCfyf4czaa', '', 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'student', '694fb5d315d80_1766831571.jpeg', 'active', '2025-12-27 10:32:51', '2025-12-27 11:15:27'),
(8, 'Siam Ahmed', 'siam@alu.com', '$2y$10$4C3uj48olfW133Lq9qMU7O5UcABXJGr76m1Km0q3cS5c/CWsd5Qu6', 'CSE 182', 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'alumni', '694fb992c1d08_1766832530.jpg', 'active', '2025-12-27 10:48:50', '2025-12-27 11:15:27'),
(9, 'Omar', 'omar123@gmail.com', '$2y$10$xdSyK5hruSc/jCxE3Myow.bnKfdewysxlxZI0j1/3fFWQ9E7KwOfu', 'CSE 192', 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'alumni', '694fbc6810f01_1766833256.png', 'active', '2025-12-27 11:00:56', '2025-12-27 11:15:27'),
(10, 'mmm', 'mmmmm12@gmail.com', '$2y$10$1mJYfvX6LliXduTdFOM0fufcCqiTTHWRhv5vYnUKlyYtnPvBlwbNq', 'CSE 192', 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'alumni', '694fbd884d124_1766833544.png', 'active', '2025-12-27 11:05:44', '2025-12-27 11:15:27'),
(11, 'Hasan hossain', 'mollaoamr2009@gmaail.com', '$2y$10$mXPdtKAjugnSPJXPnP7mhufuW07BtTTDDWxUzyjqmC8iMhdxeyGIq', '', 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'student', '6963ef59dfc91_1768157017.png', 'active', '2026-01-11 18:43:37', '2026-01-11 18:43:55'),
(12, 'Mehmed Hasan', 'mollaomar991@gmail.com', '$2y$10$0mcZKhehui8sv7mZHrnOMuR1gIWSmObQLxBOTaK7mV0lQA7ZbPIQW', '', 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'student', '6963f13f9a7bc_1768157503.png', 'active', '2026-01-11 18:51:43', '2026-01-11 18:52:05'),
(13, 'Borhan uddin', 'borhanu331@gmail.com', '$2y$10$gLhMGKyS8LyZy65ehpagf.QAMQVhfX6ddi07jSBeBEmkGY2eRz3pC', 'CSE 192', 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'alumni', '6963f72f3f17e_1768159023.png', 'active', '2026-01-11 19:17:03', '2026-01-11 19:17:27'),
(14, 'Hamzza bin denjalez', 'mollaomarofficial@gmail.com', '$2y$10$v72lOpTQfku4tWBFIhJj1uPUQhwau098Da8quobA7oy9JBUH/qoBa', 'CSE 221', 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'alumni', '6963ffeac5478_1768161258.png', 'active', '2026-01-11 19:54:18', '2026-01-11 19:56:22'),
(15, 'Molla Omar', 'mollaomar9022@gmail.com', '$2y$10$TUv.KiJ6FkXNJ/SpD6tgOOgDCQRiF3WFHpN0Zcvh.ZtGUE9rAX.Sm', 'CSE 191', 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'alumni', '696400470ad1a_1768161351.png', 'active', '2026-01-11 19:55:51', '2026-01-11 19:56:10'),
(16, 'Alif ahmed', 'mdmehmed991@gmail.com', '$2y$10$djLN6NSfY4TYtHM22lD71uTHfd.R5RSeqUXZ/mHJXGMzKfaNbtrVS', 'EEE 232', 'Electrical & Electronic Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'alumni', '6964030cb8d65_1768162060.png', 'active', '2026-01-11 20:07:40', '2026-01-11 20:07:57'),
(17, 'yakub', 'omarmolla9022@gmail.com', '$2y$10$Fhou64D8oPpVaiOpcfpg1.To4hIyC7UUfkYmk8xP7amduJlj3udY6', NULL, 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'student', '69648ab80736e_1768196792.png', 'active', '2026-01-12 05:46:32', '2026-01-12 05:48:18'),
(21, 'shakib rahman', 'shakib01@gmaiil.com', '$2y$10$fdTBKCMi865fCaAAlINACuM6RULHmGP0/4RG8qkZXP.y8EjJaR1CW', NULL, 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'student', '696fef1e74160_1768943390.jpg', 'active', '2026-01-20 21:09:50', '2026-01-20 21:16:04'),
(22, 'Md Mottasim Leemon', 'mottasin117@uiu.ac.bd', '$2y$10$Q8WlyEE2EoQByw8xs482/eNCYEpvPtWNfGF0w6ErW1/x6S.XSh20q', 'CSE 171', 'Computer Science & Engineering', NULL, NULL, 'default-avatar.png', NULL, NULL, NULL, NULL, NULL, 'alumni', '696ff2452ea89_1768944197.jpeg', 'active', '2026-01-20 21:23:17', '2026-01-20 21:23:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_username` (`username`);

--
-- Indexes for table `batches`
--
ALTER TABLE `batches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_batch_dept` (`batch_name`,`department`),
  ADD KEY `idx_batch_name` (`batch_name`),
  ADD KEY `idx_department` (`department`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_post_id` (`post_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `donations`
--
ALTER TABLE `donations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fundraiser` (`fundraiser_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_event_date` (`event_date`),
  ADD KEY `idx_is_featured` (`is_featured`);

--
-- Indexes for table `event_participants`
--
ALTER TABLE `event_participants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_participation` (`event_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `fundraisers`
--
ALTER TABLE `fundraisers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_batch` (`batch`),
  ADD KEY `idx_department` (`department`),
  ADD KEY `idx_event_type` (`event_type`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `gallery_likes`
--
ALTER TABLE `gallery_likes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_like` (`gallery_id`,`user_id`),
  ADD KEY `idx_gallery_id` (`gallery_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `group_messages`
--
ALTER TABLE `group_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_group` (`group_type`,`group_value`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_posted_by` (`posted_by`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_like` (`post_id`,`user_id`),
  ADD KEY `idx_post_id` (`post_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `mentorship_requests`
--
ALTER TABLE `mentorship_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_request` (`mentor_id`,`mentee_id`),
  ADD KEY `mentee_id` (`mentee_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sender` (`sender_id`),
  ADD KEY `idx_receiver` (`receiver_id`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_token` (`token`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_visibility` (`visibility`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_pinned` (`is_pinned`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_batch` (`batch`),
  ADD KEY `idx_department` (`department`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_role` (`role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `batches`
--
ALTER TABLE `batches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `donations`
--
ALTER TABLE `donations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `event_participants`
--
ALTER TABLE `event_participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fundraisers`
--
ALTER TABLE `fundraisers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gallery_likes`
--
ALTER TABLE `gallery_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `group_messages`
--
ALTER TABLE `group_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mentorship_requests`
--
ALTER TABLE `mentorship_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `donations`
--
ALTER TABLE `donations`
  ADD CONSTRAINT `donations_ibfk_1` FOREIGN KEY (`fundraiser_id`) REFERENCES `fundraisers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `donations_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admin` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `event_participants`
--
ALTER TABLE `event_participants`
  ADD CONSTRAINT `event_participants_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_participants_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `fundraisers`
--
ALTER TABLE `fundraisers`
  ADD CONSTRAINT `fundraisers_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admin` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `gallery`
--
ALTER TABLE `gallery`
  ADD CONSTRAINT `gallery_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `gallery_likes`
--
ALTER TABLE `gallery_likes`
  ADD CONSTRAINT `gallery_likes_ibfk_1` FOREIGN KEY (`gallery_id`) REFERENCES `gallery` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `gallery_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `group_messages`
--
ALTER TABLE `group_messages`
  ADD CONSTRAINT `group_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jobs`
--
ALTER TABLE `jobs`
  ADD CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`posted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mentorship_requests`
--
ALTER TABLE `mentorship_requests`
  ADD CONSTRAINT `mentorship_requests_ibfk_1` FOREIGN KEY (`mentor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mentorship_requests_ibfk_2` FOREIGN KEY (`mentee_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
