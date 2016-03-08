-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 16, 2015 at 07:27 AM
-- Server version: 5.6.11
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tiny_framework`
--
CREATE DATABASE IF NOT EXISTS `tiny_framework` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `tiny_framework`;

-- --------------------------------------------------------

--
-- Table structure for table `tiny_blogs`
--

CREATE TABLE IF NOT EXISTS `tiny_blogs` (
  `blog_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` longtext NOT NULL,
  `category_id` int(10) NOT NULL,
  `created_at` int(10) NOT NULL,
  `tags` varchar(250) NOT NULL,
  PRIMARY KEY (`blog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tiny_blog_categories`
--

CREATE TABLE IF NOT EXISTS `tiny_blog_categories` (
  `category_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `blog_count` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `tiny_blog_categories`
--

INSERT INTO `tiny_blog_categories` (`category_id`, `title`, `blog_count`) VALUES
(1, 'Baby', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tiny_contents`
--

CREATE TABLE IF NOT EXISTS `tiny_contents` (
  `content_id` varbinary(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` varchar(220) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tiny_contents`
--

INSERT INTO `tiny_contents` (`content_id`, `title`, `description`, `content`) VALUES
('homeIndex', 'image', '', '{&quot;path&quot;:&quot;content/home|photo-1414849424631-8b18529a81ca.jpg&quot;,&quot;content&quot;:&quot;http://127.0.0.1/Dropbox/project/tiny/uploads/content/home/full-size/1011892_10200259381998468_2081774833_n.jpg&quot;,&quot;media_size&quot;:&quot;30&quot;,&quot;font_size&quot;:&quot;10&quot;,&quot;opacity&quot;:&quot;80&quot;}');

-- --------------------------------------------------------

--
-- Table structure for table `tiny_item_images`
--

CREATE TABLE IF NOT EXISTS `tiny_item_images` (
  `item_id` int(10) NOT NULL,
  `path` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tiny_menus`
--

CREATE TABLE IF NOT EXISTS `tiny_menus` (
  `menu_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `parent` int(10) NOT NULL,
  `permission_id` varbinary(35) NOT NULL,
  `weight` int(5) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: disable 1: active',
  `link` varchar(200) NOT NULL,
  `icon` varchar(100) NOT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `tiny_menus`
--

INSERT INTO `tiny_menus` (`menu_id`, `title`, `parent`, `permission_id`, `weight`, `status`, `link`, `icon`) VALUES
(1, 'Dashboard', 0, '', 0, 1, 'admin/home', 'fa fa-home'),
(4, 'Create Gallery', 3, '', 0, 1, '-/uploads', 'fa fa-upload'),
(5, 'Administrator', 0, 'adminPermission', 4, 1, 'admin/administrator', 'fa fa-h-square'),
(6, 'Permissions Manager', 5, 'adminPermission', 0, 1, '-/permission', 'fa fa-lock'),
(7, 'List User Group', 5, '', 1, 1, '-/groupuser', 'fa fa-users'),
(8, 'Peoples', 5, '', 2, 1, '-/peoples', 'fa fa-user'),
(9, 'Members List', 8, '', 0, 1, '-/', ' '),
(10, 'Add Member', 8, '', 1, 1, '-/add', ' '),
(11, 'Menu Manager', 5, '', 3, 1, '-/menu', 'fa fa-barcode'),
(12, 'Content', 0, 'contentManage', 1, 1, 'admin/content', 'fa fa-list-alt'),
(13, 'Products', 0, 'manAllProduct', 3, 1, 'admin/product/', 'fa fa-database'),
(14, 'About Content', 12, 'contentManage', 0, 1, '-/about', 'fa fa-buysellads'),
(15, 'Contact Content', 12, 'contentManage', 1, 1, '-/contact', 'fa fa-envelope-o'),
(18, 'Blogs', 0, 'manageBlog', 2, 1, 'admin/blog', 'fa fa-bold'),
(19, 'All Blogs', 18, 'manageBlog', 0, 1, '-/', 'fa fa-newspaper-o'),
(20, 'Add New', 18, 'addBlog', 1, 1, '-/add', 'fa fa-file-o'),
(21, 'Categories', 18, 'manageCateBlog', 2, 1, '-/categories', 'fa fa-list-ul'),
(22, 'Home Seup', 12, 'contentManage', 2, 1, '-/home', 'fa fa-home'),
(23, 'Slide Manager', 12, '', 0, 1, '-/slide', 'fa fa-image');

-- --------------------------------------------------------

--
-- Table structure for table `tiny_permissions`
--

CREATE TABLE IF NOT EXISTS `tiny_permissions` (
  `permission_id` varbinary(35) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` varchar(200) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tiny_permissions`
--

INSERT INTO `tiny_permissions` (`permission_id`, `title`, `description`, `group_id`) VALUES
('addAdminMenu', 'Add Menu Admin', 'Allow user add menu for administrator', 7),
('addBlog', 'Add New Blog', 'Allow copywriter add new post', 10),
('adminLogin', 'Admin Login', 'Permission allow admin login to Administrator Page', 1),
('adminPermission', 'Admin Permission Manage', 'Admin manage all permission', 1),
('contentManage', 'Content management list', 'manage content list on all sites', 8),
('getUserData', 'Get User Data', 'Get all infomation of user login', 1),
('manAllProduct', 'Manager All Products', 'Allow admin manage and edit title, image of all product', 9),
('manageBlog', 'Manage Blog', '', 10),
('manageCateBlog', 'Manager Categories Blog', 'Manager, add, delete Categories Blog', 10),
('postComment', 'Comment to post', 'Permission allow user commment to post', 2),
('productadd', 'Add new Product', 'Add new product', 9),
('productadditems', 'Product Add Item', 'Add item to Product', 9),
('userGroup', 'Manage User Group', 'Administrator manage all group of users', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tiny_permission_groups`
--

CREATE TABLE IF NOT EXISTS `tiny_permission_groups` (
  `permission_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '1: admin 0: users',
  PRIMARY KEY (`permission_group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `tiny_permission_groups`
--

INSERT INTO `tiny_permission_groups` (`permission_group_id`, `title`, `type`) VALUES
(1, 'Administrator Manage', 1),
(2, 'View Posts', 0),
(7, 'Menu management', 1),
(8, 'Content Management', 1),
(9, 'Products management', 1),
(10, 'Blog Management', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tiny_products`
--

CREATE TABLE IF NOT EXISTS `tiny_products` (
  `product_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `image` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `order` int(10) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tiny_product_items`
--

CREATE TABLE IF NOT EXISTS `tiny_product_items` (
  `product_item_id` int(10) NOT NULL AUTO_INCREMENT,
  `product_id` int(10) NOT NULL,
  `item_name` varchar(200) NOT NULL,
  `item_description` longtext NOT NULL,
  `item_image` varchar(200) NOT NULL,
  `order` int(10) NOT NULL,
  `item_detail` longtext NOT NULL,
  PRIMARY KEY (`product_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tiny_product_posts`
--

CREATE TABLE IF NOT EXISTS `tiny_product_posts` (
  `product_post_id` int(10) NOT NULL AUTO_INCREMENT,
  `product_id` int(10) NOT NULL,
  `name` varchar(200) NOT NULL,
  `content` longtext NOT NULL,
  `order` int(10) NOT NULL,
  PRIMARY KEY (`product_post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tiny_users`
--

CREATE TABLE IF NOT EXISTS `tiny_users` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `facebook_id` int(50) DEFAULT NULL,
  `group_id` int(10) NOT NULL,
  `secondary_group` varbinary(200) DEFAULT NULL,
  `permission_denied` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tiny_users`
--

INSERT INTO `tiny_users` (`user_id`, `username`, `password`, `email`, `full_name`, `facebook_id`, `group_id`, `secondary_group`, `permission_denied`) VALUES
(1, 'yuyunguyen', '0', 'hungtranqt93@gmail.com', 'Trần Vĩnh Hưng', NULL, 2, '3', 'userGroup,addAdminMenu'),
(3, 'admin', '0', 'hungtranqt@hotmail.com', 'Trần Hưng', NULL, 2, '', NULL),
(4, 'tinygiant', '0', 'tinygiant@gmail.com', 'Tiny''s Giant', NULL, 3, '', 'adminPermission');

-- --------------------------------------------------------

--
-- Table structure for table `tiny_user_groups`
--

CREATE TABLE IF NOT EXISTS `tiny_user_groups` (
  `user_group_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `permission_ids` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `tiny_user_groups`
--

INSERT INTO `tiny_user_groups` (`user_group_id`, `title`, `permission_ids`) VALUES
(1, 'Unregistered / Unconfirmed', NULL),
(2, 'Administrator', 'adminLogin,adminPermission,getUserData,userGroup,addAdminMenu,contentManage,manAllProduct,productadd,productadditems,manageBlog,addBlog,manageCateBlog'),
(3, 'Photographer', 'adminPermission,userGroup,fdsfds,manAllProduct,product-add-items');

-- --------------------------------------------------------

--
-- Table structure for table `tiny_user_permission`
--

CREATE TABLE IF NOT EXISTS `tiny_user_permission` (
  `user_id` int(10) NOT NULL,
  `permission_id` varbinary(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tiny_user_permission`
--

INSERT INTO `tiny_user_permission` (`user_id`, `permission_id`) VALUES
(1, 'postComment'),
(4, 'getUserData');

-- --------------------------------------------------------

--
-- Table structure for table `tiny_user_profile`
--

CREATE TABLE IF NOT EXISTS `tiny_user_profile` (
  `user_id` int(10) NOT NULL,
  `address` varchar(200) NOT NULL,
  `phone` int(15) NOT NULL,
  `birth_date` int(10) NOT NULL,
  `avatar_link` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tiny_user_profile`
--

INSERT INTO `tiny_user_profile` (`user_id`, `address`, `phone`, `birth_date`, `avatar_link`) VALUES
(1, '196 Vạn Kiếp. Q.Bình Thạnh', 933885715, 745884000, 'tiny|1957859_467275776732788_684214433_o.jpg'),
(3, '110 Lý Phục Man, P.10, Q7', 2147483647, 745884000, 'tiny|1957859_467275776732788_684214433_o.jpg'),
(4, 'Level 13, Room 12A.5, 45-47 Dang Thi Nhu, Nguyen Thai Binh ward, Ho Chi Minh', 2147483647, 1434837600, 'tiny|11.jpg');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
