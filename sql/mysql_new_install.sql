CREATE TABLE IF NOT EXISTS `contactgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_short` varchar(255) CHARACTER SET latin1 NOT NULL,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `view_only` tinyint(1) NOT NULL DEFAULT '0',
  `timeframe_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_short` (`name_short`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

INSERT INTO `contactgroups` (`id`, `name_short`, `name`, `view_only`, `timeframe_id`) VALUES
(1, 'group1', 'Group 1', 0, 1);

CREATE TABLE IF NOT EXISTS `contactgroups_to_contacts` (
  `contactgroup_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  KEY `contactgroup_id` (`contactgroup_id`),
  KEY `contact_id` (`contact_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `contactgroups_to_contacts` (`contactgroup_id`, `contact_id`) VALUES
(1, 2);

CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin` tinyint(1) NOT NULL,
  `username` varchar(255) CHARACTER SET latin1 NOT NULL,
  `first_name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `last_name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `email` varchar(255) CHARACTER SET latin1 NOT NULL,
  `phone` varchar(255) CHARACTER SET latin1 NOT NULL,
  `mobile` varchar(255) CHARACTER SET latin1 NOT NULL,
  `section` varchar(255) NOT NULL,
  `netaddress` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `timeframe_id` int(11) NOT NULL,
  `timezone_id` int(11) NOT NULL,
  `restrict_alerts` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

INSERT INTO `contacts` (`id`, `admin`, `username`, `first_name`, `last_name`, `email`, `phone`, `mobile`, `section`, `netaddress`, `password`, `timeframe_id`, `timezone_id`, `restrict_alerts`) VALUES
(1, 0, '[---]', '', '', '', '', '', '', '', '', 0, 0, NULL),
(2, 1, 'nagiosadmin', 'Nagios', 'Administrator', 'root@localhost', '', '', '', '192.168.1.109', sha1('nagiosadmin'), 1, 305, 0);

CREATE TABLE IF NOT EXISTS `escalations_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) NOT NULL,
  `on_ok` tinyint(1) NOT NULL,
  `on_warning` tinyint(1) NOT NULL,
  `on_critical` tinyint(1) NOT NULL,
  `on_unknown` tinyint(1) NOT NULL,
  `on_host_up` tinyint(1) NOT NULL,
  `on_host_unreachable` tinyint(1) NOT NULL,
  `on_host_down` tinyint(1) NOT NULL,
  `on_type_problem` tinyint(1) NOT NULL,
  `on_type_recovery` tinyint(1) NOT NULL,
  `on_type_flappingstart` tinyint(1) NOT NULL,
  `on_type_flappingstop` tinyint(1) NOT NULL,
  `on_type_flappingdisabled` tinyint(1) NOT NULL,
  `on_type_downtimestart` tinyint(1) NOT NULL,
  `on_type_downtimeend` tinyint(1) NOT NULL,
  `on_type_downtimecancelled` tinyint(1) NOT NULL,
  `on_type_acknowledgement` tinyint(1) NOT NULL,
  `on_type_custom` tinyint(1) NOT NULL,
  `notify_after_tries` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `notification_id` (`notification_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

CREATE TABLE IF NOT EXISTS `escalations_contacts_to_contactgroups` (
  `escalation_contacts_id` int(11) NOT NULL,
  `contactgroup_id` int(11) NOT NULL,
  KEY `contactgroup_id` (`contactgroup_id`),
  KEY `escalation_contacts_id` (`escalation_contacts_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `escalations_contacts_to_contacts` (
  `escalation_contacts_id` int(11) NOT NULL,
  `contacts_id` int(11) NOT NULL,
  KEY `escalation_contacts_id` (`escalation_contacts_id`),
  KEY `contacts_id` (`contacts_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `escalations_contacts_to_methods` (
  `escalation_contacts_id` int(11) NOT NULL,
  `method_id` int(11) NOT NULL,
  KEY `escalation_contacts_id` (`escalation_contacts_id`),
  KEY `method_id` (`method_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `escalation_stati` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_rule` int(11) DEFAULT NULL,
  `starttime` int(11) NOT NULL,
  `counter` int(11) NOT NULL,
  `incident_id` bigint(20) NOT NULL,
  `recipients` varchar(255) NOT NULL,
  `host` varchar(255) CHARACTER SET latin1 NOT NULL,
  `host_alias` varchar(255) DEFAULT NULL,
  `host_address` varchar(255) DEFAULT NULL,
  `hostgroups` varchar(255) NOT NULL,
  `service` varchar(255) CHARACTER SET latin1 NOT NULL,
  `servicegroups` varchar(255) NOT NULL,
  `check_type` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `time_string` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `output` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

CREATE TABLE IF NOT EXISTS `holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL,
  `username` varchar(255) CHARACTER SET latin1 NOT NULL,
  `recipients_include` varchar(255) NOT NULL,
  `recipients_exclude` varchar(255) NOT NULL,
  `hosts_include` varchar(255) CHARACTER SET latin1 NOT NULL,
  `hosts_exclude` varchar(255) CHARACTER SET latin1 NOT NULL,
  `hostgroups_include` varchar(255) CHARACTER SET latin1 NOT NULL,
  `hostgroups_exclude` varchar(255) CHARACTER SET latin1 NOT NULL,
  `services_include` varchar(255) CHARACTER SET latin1 NOT NULL,
  `services_exclude` varchar(255) CHARACTER SET latin1 NOT NULL,
  `servicegroups_include` varchar(255) CHARACTER SET latin1 NOT NULL,
  `servicegroups_exclude` varchar(255) CHARACTER SET latin1 NOT NULL,
  `notify_after_tries` varchar(10) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `let_notifier_handle` tinyint(1) NOT NULL,
  `rollover` tinyint(1) DEFAULT '0',
  `reloop_delay` int(11) NOT NULL DEFAULT '0',
  `on_ok` tinyint(1) NOT NULL,
  `on_warning` tinyint(1) NOT NULL,
  `on_unknown` tinyint(1) NOT NULL,
  `on_host_unreachable` tinyint(1) NOT NULL,
  `on_critical` tinyint(1) NOT NULL,
  `on_host_up` tinyint(1) NOT NULL,
  `on_host_down` tinyint(1) NOT NULL,
  `on_type_problem` tinyint(1) NOT NULL,
  `on_type_recovery` tinyint(1) NOT NULL,
  `on_type_flappingstart` tinyint(1) NOT NULL,
  `on_type_flappingstop` tinyint(1) NOT NULL,
  `on_type_flappingdisabled` tinyint(1) NOT NULL,
  `on_type_downtimestart` tinyint(1) NOT NULL,
  `on_type_downtimeend` tinyint(1) NOT NULL,
  `on_type_downtimecancelled` tinyint(1) NOT NULL,
  `on_type_acknowledgement` tinyint(1) NOT NULL,
  `on_type_custom` tinyint(1) NOT NULL,
  `timezone_id` int(11) NOT NULL DEFAULT '372',
  `timeframe_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

INSERT INTO `notifications` (`id`, `active`, `username`, `recipients_include`, `recipients_exclude`, `hosts_include`, `hosts_exclude`, `hostgroups_include`, `hostgroups_exclude`, `services_include`, `services_exclude`, `servicegroups_include`, `servicegroups_exclude`, `notify_after_tries`, `let_notifier_handle`, `rollover`, `reloop_delay`, `on_ok`, `on_warning`, `on_unknown`, `on_host_unreachable`, `on_critical`, `on_host_up`, `on_host_down`, `on_type_problem`, `on_type_recovery`, `on_type_flappingstart`, `on_type_flappingstop`, `on_type_flappingdisabled`, `on_type_downtimestart`, `on_type_downtimeend`, `on_type_downtimecancelled`, `on_type_acknowledgement`, `on_type_custom`, `timezone_id`, `timeframe_id`) VALUES
(1, 1, '', '', '', '*', '', '*', '', '*', '', '*', '', '1', 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 319, 1);

CREATE TABLE IF NOT EXISTS `notifications_to_contactgroups` (
  `notification_id` int(11) NOT NULL,
  `contactgroup_id` int(11) NOT NULL,
  KEY `notification_id` (`notification_id`),
  KEY `contactgroup_id` (`contactgroup_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `notifications_to_contacts` (
  `notification_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  KEY `notification_id` (`notification_id`),
  KEY `contact_id` (`contact_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `notifications_to_contacts` (`notification_id`, `contact_id`) VALUES
(6, 2),
(1, 2);

CREATE TABLE IF NOT EXISTS `notifications_to_methods` (
  `notification_id` int(11) NOT NULL,
  `method_id` int(11) NOT NULL,
  KEY `notification_id` (`notification_id`),
  KEY `method_id` (`method_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `notifications_to_methods` (`notification_id`, `method_id`) VALUES
(1, 1);

CREATE TABLE IF NOT EXISTS `notification_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `counter` int(11) NOT NULL,
  `check_type` varchar(10) CHARACTER SET latin1 NOT NULL,
  `check_result` varchar(15) CHARACTER SET latin1 NOT NULL,
  `host` varchar(255) CHARACTER SET latin1 NOT NULL,
  `service` varchar(255) CHARACTER SET latin1 NOT NULL,
  `notification_type` varchar(255) CHARACTER SET latin1 NOT NULL,
  `method` varchar(255) NOT NULL,
  `user` varchar(255) CHARACTER SET latin1 NOT NULL,
  `result` varchar(1023) NOT NULL,
  `unique_id` bigint(20) DEFAULT NULL,
  `incident_id` bigint(20) DEFAULT NULL,
  `notification_rule` int(11) DEFAULT NULL,
  `last_method` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `unique_id` (`unique_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

INSERT INTO `notification_logs` (`id`, `timestamp`, `counter`, `check_type`, `check_result`, `host`, `service`, `notification_type`, `method`, `user`, `result`, `unique_id`, `incident_id`, `notification_rule`, `last_method`) VALUES
(1,now(),1,'(internal)','OK','localhost','NoMa','(none)','(none)','NoMa successfully installed',123565999600001,123565999600001,0,1);

CREATE TABLE IF NOT EXISTS `notification_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `method` varchar(255) NOT NULL,
  `command` varchar(255) NOT NULL,
  `contact_field` varchar(255) NOT NULL,
  `from` varchar(255) NOT NULL,
  `on_fail` int(11) NOT NULL,
  `ack_able` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

INSERT INTO `notification_methods` (`id`, `method`, `command`, `contact_field`, `from`, `on_fail`, `ack_able`) VALUES
(5, 'Voice + SMS fallback', 'voicecall', 'phone', '', 2, 1),
(6, 'Growl', 'growl', 'netaddress', '', 0, 0),
(4, 'Voice + E-Mail fallback', 'voicecall', 'phone', '', 1, 1),
(3, 'Voice', 'voicecall', 'phone', '', 0, 1),
(2, 'SMS', 'sendsms', 'mobile', '', 0, 0),
(1, 'E-Mail', 'sendemail', 'email', 'noma@netways.de', 0, 0),
(7, 'Growl + E-Mail fallback', 'growl', 'netaddress', '', 1, 1),
(8, 'Growl + SMS fallback', 'growl', 'netaddress', '', 2, 1);

CREATE TABLE IF NOT EXISTS `notification_stati` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) CHARACTER SET latin1 NOT NULL,
  `service` varchar(255) CHARACTER SET latin1 NOT NULL,
  `check_type` varchar(10) CHARACTER SET latin1 NOT NULL,
  `check_result` varchar(15) CHARACTER SET latin1 NOT NULL,
  `counter` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

CREATE TABLE IF NOT EXISTS `timeframes` (
  `id` int(11) NOT NULL,
  `timeframe_name` varchar(60) COLLATE latin1_unicode_ci NOT NULL,
  `dt_validFrom` datetime NOT NULL,
  `dt_validTo` datetime DEFAULT NULL,
  `timezone_id` int(3) NOT NULL,
  `day_monday_all` tinyint(1) DEFAULT '1',
  `day_monday_1st` tinyint(1) DEFAULT '0',
  `day_monday_2nd` tinyint(1) DEFAULT '0',
  `day_monday_3rd` tinyint(1) DEFAULT '0',
  `day_monday_4th` tinyint(1) DEFAULT '0',
  `day_monday_5th` tinyint(1) DEFAULT '0',
  `day_monday_last` tinyint(1) DEFAULT '0',
  `day_tuesday_all` tinyint(1) DEFAULT '1',
  `day_tuesday_1st` tinyint(1) DEFAULT '0',
  `day_tuesday_2nd` tinyint(1) DEFAULT '0',
  `day_tuesday_3rd` tinyint(1) DEFAULT '0',
  `day_tuesday_4th` tinyint(1) DEFAULT '0',
  `day_tuesday_5th` tinyint(1) DEFAULT '0',
  `day_tuesday_last` tinyint(1) DEFAULT '0',
  `day_wednesday_all` tinyint(1) DEFAULT '1',
  `day_wednesday_1st` tinyint(1) DEFAULT '0',
  `day_wednesday_2nd` tinyint(1) DEFAULT '0',
  `day_wednesday_3rd` tinyint(1) DEFAULT '0',
  `day_wednesday_4th` tinyint(1) DEFAULT '0',
  `day_wednesday_5th` tinyint(1) DEFAULT '0',
  `day_wednesday_last` tinyint(1) DEFAULT '0',
  `day_thursday_all` tinyint(1) DEFAULT '1',
  `day_thursday_1st` tinyint(1) DEFAULT '0',
  `day_thursday_2nd` tinyint(1) DEFAULT '0',
  `day_thursday_3rd` tinyint(1) DEFAULT '0',
  `day_thursday_4th` tinyint(1) DEFAULT '0',
  `day_thursday_5th` tinyint(1) DEFAULT '0',
  `day_thursday_last` tinyint(1) DEFAULT '0',
  `day_friday_all` tinyint(1) DEFAULT '1',
  `day_friday_1st` tinyint(1) DEFAULT '0',
  `day_friday_2nd` tinyint(1) DEFAULT '0',
  `day_friday_3rd` tinyint(1) DEFAULT '0',
  `day_friday_4th` tinyint(1) DEFAULT '0',
  `day_friday_5th` tinyint(1) DEFAULT '0',
  `day_friday_last` tinyint(1) DEFAULT '0',
  `day_saturday_all` tinyint(1) DEFAULT '1',
  `day_saturday_1st` tinyint(1) DEFAULT '0',
  `day_saturday_2nd` tinyint(1) DEFAULT '0',
  `day_saturday_3rd` tinyint(1) DEFAULT '0',
  `day_saturday_4th` tinyint(1) DEFAULT '0',
  `day_saturday_5th` tinyint(1) DEFAULT '0',
  `day_saturday_last` tinyint(1) DEFAULT '0',
  `day_sunday_all` tinyint(1) DEFAULT '1',
  `day_sunday_1st` tinyint(1) DEFAULT '0',
  `day_sunday_2nd` tinyint(1) DEFAULT '0',
  `day_sunday_3rd` tinyint(1) DEFAULT '0',
  `day_sunday_4th` tinyint(1) DEFAULT '0',
  `day_sunday_5th` tinyint(1) DEFAULT '0',
  `day_sunday_last` tinyint(1) DEFAULT '0',
  `time_monday_start` time DEFAULT NULL,
  `time_monday_stop` time DEFAULT NULL,
  `time_monday_invert` tinyint(1) DEFAULT '0',
  `time_tuesday_start` time DEFAULT NULL,
  `time_tuesday_stop` time DEFAULT NULL,
  `time_tuesday_invert` tinyint(1) DEFAULT '0',
  `time_wednesday_start` time DEFAULT NULL,
  `time_wednesday_stop` time DEFAULT NULL,
  `time_wednesday_invert` tinyint(1) DEFAULT '0',
  `time_thursday_start` time DEFAULT NULL,
  `time_thursday_stop` time DEFAULT NULL,
  `time_thursday_invert` tinyint(1) DEFAULT '0',
  `time_friday_start` time DEFAULT NULL,
  `time_friday_stop` time DEFAULT NULL,
  `time_friday_invert` tinyint(1) DEFAULT '0',
  `time_saturday_start` time DEFAULT NULL,
  `time_saturday_stop` time DEFAULT NULL,
  `time_saturday_invert` tinyint(1) DEFAULT '0',
  `time_sunday_start` time DEFAULT NULL,
  `time_sunday_stop` time DEFAULT NULL,
  `time_sunday_invert` tinyint(1) DEFAULT '0',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `timeframes` (`id`, `timeframe_name`, `dt_validFrom`, `dt_validTo`, `timezone_id`, `day_monday_all`, `day_monday_1st`, `day_monday_2nd`, `day_monday_3rd`, `day_monday_4th`, `day_monday_5th`, `day_monday_last`, `day_tuesday_all`, `day_tuesday_1st`, `day_tuesday_2nd`, `day_tuesday_3rd`, `day_tuesday_4th`, `day_tuesday_5th`, `day_tuesday_last`, `day_wednesday_all`, `day_wednesday_1st`, `day_wednesday_2nd`, `day_wednesday_3rd`, `day_wednesday_4th`, `day_wednesday_5th`, `day_wednesday_last`, `day_thursday_all`, `day_thursday_1st`, `day_thursday_2nd`, `day_thursday_3rd`, `day_thursday_4th`, `day_thursday_5th`, `day_thursday_last`, `day_friday_all`, `day_friday_1st`, `day_friday_2nd`, `day_friday_3rd`, `day_friday_4th`, `day_friday_5th`, `day_friday_last`, `day_saturday_all`, `day_saturday_1st`, `day_saturday_2nd`, `day_saturday_3rd`, `day_saturday_4th`, `day_saturday_5th`, `day_saturday_last`, `day_sunday_all`, `day_sunday_1st`, `day_sunday_2nd`, `day_sunday_3rd`, `day_sunday_4th`, `day_sunday_5th`, `day_sunday_last`, `time_monday_start`, `time_monday_stop`, `time_monday_invert`, `time_tuesday_start`, `time_tuesday_stop`, `time_tuesday_invert`, `time_wednesday_start`, `time_wednesday_stop`, `time_wednesday_invert`, `time_thursday_start`, `time_thursday_stop`, `time_thursday_invert`, `time_friday_start`, `time_friday_stop`, `time_friday_invert`, `time_saturday_start`, `time_saturday_stop`, `time_saturday_invert`, `time_sunday_start`, `time_sunday_stop`, `time_sunday_invert`) VALUES
(0, '[---]', '2011-07-31 00:00:00', '2021-12-31 23:59:00', 305, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '00:00:00', '23:59:59', 1, '00:00:00', '23:59:59', 1, '00:00:00', '23:59:59', 1, '00:00:00', '23:59:59', 1, '00:00:00', '23:59:59', 1, '00:00:00', '23:59:59', 1, '00:00:00', '23:59:59', 1),
(1, '24x7', '2011-07-31 00:00:00', '2021-12-31 23:59:00', 305, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '00:00:00', '23:59:59', 0, '00:00:00', '23:59:59', 0, '00:00:00', '23:59:59', 0, '00:00:00', '23:59:59', 0, '00:00:00', '23:59:59', 0, '00:00:00', '23:59:59', 0, '00:00:00', '23:59:59', 0);

CREATE TABLE IF NOT EXISTS `timezones` (
  `id` int(11) NOT NULL,
  `timezone` varchar(255) CHARACTER SET latin1 NOT NULL,
  `time_diff` tinyint(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `timezones` (`id`, `timezone`, `time_diff`) VALUES
(1, 'Africa/Abidjan', 0),
(2, 'Africa/Accra', 0),
(3, 'Africa/Addis_Ababa', 3),
(4, 'Africa/Algiers', 1),
(5, 'Africa/Asmera', 3),
(6, 'Africa/Bamako', 0),
(7, 'Africa/Bangui', 1),
(8, 'Africa/Banjul', 0),
(9, 'Africa/Bissau', 0),
(10, 'Africa/Blantyre', 2),
(11, 'Africa/Brazzaville', 1),
(12, 'Africa/Bujumbura', 2),
(13, 'Africa/Cairo', 2),
(14, 'Africa/Casablanca', 0),
(15, 'Africa/Ceuta', 1),
(16, 'Africa/Conakry', 0),
(17, 'Africa/Dakar', 0),
(18, 'Africa/Dar_es_Salaam', 3),
(19, 'Africa/Djibouti', 3),
(20, 'Africa/Douala', 1),
(21, 'Africa/El_Aaiun', 0),
(22, 'Africa/Freetown', 0),
(23, 'Africa/Gaborone', 2),
(24, 'Africa/Harare', 2),
(25, 'Africa/Johannesburg', 2),
(26, 'Africa/Kampala', 3),
(27, 'Africa/Khartoum', 3),
(28, 'Africa/Kigali', 2),
(29, 'Africa/Kinshasa', 1),
(30, 'Africa/Lagos', 1),
(31, 'Africa/Libreville', 1),
(32, 'Africa/Lome', 0),
(33, 'Africa/Luanda', 1),
(34, 'Africa/Lubumbashi', 2),
(35, 'Africa/Lusaka', 2),
(36, 'Africa/Malabo', 1),
(37, 'Africa/Maputo', 2),
(38, 'Africa/Maseru', 2),
(39, 'Africa/Mbabane', 2),
(40, 'Africa/Mogadishu', 3),
(41, 'Africa/Monrovia', 0),
(42, 'Africa/Nairobi', 3),
(43, 'Africa/Ndjamena', 1),
(44, 'Africa/Niamey', 1),
(45, 'Africa/Nouakchott', 0),
(46, 'Africa/Ouagadougou', 0),
(47, 'Africa/Porto-Novo', 1),
(48, 'Africa/Sao_Tome', 0),
(49, 'Africa/Tripoli', 2),
(50, 'Africa/Tunis', 1),
(51, 'Africa/Windhoek', 2),
(52, 'America/Adak', -10),
(53, 'America/Anchorage', -9),
(54, 'America/Anguilla', -4),
(55, 'America/Antigua', -4),
(56, 'America/Araguaina', -3),
(57, 'America/Argentina/Buenos_Aires', -3),
(58, 'America/Argentina/Catamarca', -3),
(59, 'America/Argentina/Cordoba', -3),
(60, 'America/Argentina/Jujuy', -3),
(61, 'America/Argentina/La_Rioja', -3),
(62, 'America/Argentina/Mendoza', -3),
(63, 'America/Argentina/Rio_Gallegos', -3),
(64, 'America/Argentina/San_Juan', -3),
(65, 'America/Argentina/Tucuman', -3),
(66, 'America/Argentina/Ushuaia', -3),
(67, 'America/Aruba', -4),
(68, 'America/Asuncion', -3),
(69, 'America/Bahia', -3),
(70, 'America/Barbados', -4),
(71, 'America/Belem', -3),
(72, 'America/Belize', -6),
(73, 'America/Boa_Vista', -4),
(74, 'America/Bogota', -5),
(75, 'America/Boise', -7),
(76, 'America/Cambridge_Bay', -7),
(77, 'America/Campo_Grande', -3),
(78, 'America/Cancun', -6),
(79, 'America/Caracas', -4),
(80, 'America/Cayenne', -3),
(81, 'America/Cayman', -5),
(82, 'America/Chicago', -6),
(83, 'America/Chihuahua', -7),
(84, 'America/Coral_Harbour', -5),
(85, 'America/Costa_Rica', -6),
(86, 'America/Cuiaba', -3),
(87, 'America/Curacao', -4),
(88, 'America/Danmarkshavn', 0),
(89, 'America/Dawson', -8),
(90, 'America/Dawson_Creek', -7),
(91, 'America/Denver', -7),
(92, 'America/Detroit', -5),
(93, 'America/Dominica', -4),
(94, 'America/Edmonton', -7),
(95, 'America/Eirunepe', -5),
(96, 'America/El_Salvador', -6),
(97, 'America/Fortaleza', -3),
(98, 'America/Glace_Bay', -4),
(99, 'America/Godthab', -3),
(100, 'America/Goose_Bay', -4),
(101, 'America/Grand_Turk', -5),
(102, 'America/Grenada', -4),
(103, 'America/Guadeloupe', -4),
(104, 'America/Guatemala', -6),
(105, 'America/Guayaquil', -5),
(106, 'America/Guyana', -4),
(107, 'America/Halifax', -4),
(108, 'America/Havana', -5),
(109, 'America/Hermosillo', -7),
(110, 'America/Indiana/Indianapolis', -5),
(111, 'America/Indiana/Knox', -6),
(112, 'America/Indiana/Marengo', -5),
(113, 'America/Indiana/Vevay', -5),
(114, 'America/Inuvik', -7),
(115, 'America/Iqaluit', -5),
(116, 'America/Jamaica', -5),
(117, 'America/Juneau', -9),
(118, 'America/Kentucky/Louisville', -5),
(119, 'America/Kentucky/Monticello', -5),
(120, 'America/La_Paz', -4),
(121, 'America/Lima', -5),
(122, 'America/Los_Angeles', -8),
(123, 'America/Maceio', -3),
(124, 'America/Managua', -6),
(125, 'America/Manaus', -4),
(126, 'America/Martinique', -4),
(127, 'America/Mazatlan', -7),
(128, 'America/Menominee', -6),
(129, 'America/Merida', -6),
(130, 'America/Mexico_City', -6),
(131, 'America/Miquelon', -3),
(132, 'America/Monterrey', -6),
(133, 'America/Montevideo', -2),
(134, 'America/Montreal', -5),
(135, 'America/Montserrat', -4),
(136, 'America/Nassau', -5),
(137, 'America/New_York', -5),
(138, 'America/Nipigon', -5),
(139, 'America/Nome', -9),
(140, 'America/Noronha', -2),
(141, 'America/North_Dakota/Center', -6),
(142, 'America/Panama', -5),
(143, 'America/Pangnirtung', -5),
(144, 'America/Paramaribo', -3),
(145, 'America/Phoenix', -7),
(146, 'America/Port-au-Prince', -5),
(147, 'America/Port_of_Spain', -4),
(148, 'America/Porto_Velho', -4),
(149, 'America/Puerto_Rico', -4),
(150, 'America/Rainy_River', -6),
(151, 'America/Rankin_Inlet', -6),
(152, 'America/Recife', -3),
(153, 'America/Regina', -6),
(154, 'America/Rio_Branco', -5),
(155, 'America/Santiago', -3),
(156, 'America/Santo_Domingo', -4),
(157, 'America/Sao_Paulo', -2),
(158, 'America/Scoresbysund', -1),
(159, 'America/St_Johns', -3),
(160, 'America/St_Kitts', -4),
(161, 'America/St_Lucia', -4),
(162, 'America/St_Thomas', -4),
(163, 'America/St_Vincent', -4),
(164, 'America/Swift_Current', -6),
(165, 'America/Tegucigalpa', -6),
(166, 'America/Thule', -4),
(167, 'America/Thunder_Bay', -5),
(168, 'America/Tijuana', -8),
(169, 'America/Toronto', -5),
(170, 'America/Tortola', -4),
(171, 'America/Vancouver', -8),
(172, 'America/Whitehorse', -8),
(173, 'America/Winnipeg', -6),
(174, 'America/Yakutat', -9),
(175, 'America/Yellowknife', -7),
(176, 'Antarctica/Casey', 8),
(177, 'Antarctica/Davis', 7),
(178, 'Antarctica/DumontDUrville', 10),
(179, 'Antarctica/Mawson', 6),
(180, 'Antarctica/McMurdo', 13),
(181, 'Antarctica/Palmer', -3),
(182, 'Antarctica/Rothera', -3),
(183, 'Antarctica/Syowa', 3),
(184, 'Antarctica/Vostok', 6),
(185, 'Asia/Aden', 3),
(186, 'Asia/Almaty', 6),
(187, 'Asia/Amman', 2),
(188, 'Asia/Anadyr', 12),
(189, 'Asia/Aqtau', 5),
(190, 'Asia/Aqtobe', 5),
(191, 'Asia/Ashgabat', 5),
(192, 'Asia/Baghdad', 3),
(193, 'Asia/Bahrain', 3),
(194, 'Asia/Baku', 4),
(195, 'Asia/Bangkok', 7),
(196, 'Asia/Beirut', 2),
(197, 'Asia/Bishkek', 6),
(198, 'Asia/Brunei', 8),
(199, 'Asia/Calcutta', 5),
(200, 'Asia/Choibalsan', 9),
(201, 'Asia/Chongqing', 8),
(202, 'Asia/Colombo', 5),
(203, 'Asia/Damascus', 2),
(204, 'Asia/Dhaka', 6),
(205, 'Asia/Dili', 9),
(206, 'Asia/Dubai', 4),
(207, 'Asia/Dushanbe', 5),
(208, 'Asia/Gaza', 2),
(209, 'Asia/Harbin', 8),
(210, 'Asia/Hong_Kong', 8),
(211, 'Asia/Hovd', 7),
(212, 'Asia/Irkutsk', 8),
(213, 'Asia/Jakarta', 7),
(214, 'Asia/Jayapura', 9),
(215, 'Asia/Jerusalem', 2),
(216, 'Asia/Kabul', 4),
(217, 'Asia/Kamchatka', 12),
(218, 'Asia/Karachi', 5),
(219, 'Asia/Kashgar', 8),
(220, 'Asia/Katmandu', 5),
(221, 'Asia/Krasnoyarsk', 7),
(222, 'Asia/Kuala_Lumpur', 8),
(223, 'Asia/Kuching', 8),
(224, 'Asia/Kuwait', 3),
(225, 'Asia/Macau', 8),
(226, 'Asia/Magadan', 11),
(227, 'Asia/Makassar', 8),
(228, 'Asia/Manila', 8),
(229, 'Asia/Muscat', 4),
(230, 'Asia/Nicosia', 2),
(231, 'Asia/Novosibirsk', 6),
(232, 'Asia/Omsk', 6),
(233, 'Asia/Oral', 5),
(234, 'Asia/Phnom_Penh', 7),
(235, 'Asia/Pontianak', 7),
(236, 'Asia/Pyongyang', 9),
(237, 'Asia/Qatar', 3),
(238, 'Asia/Qyzylorda', 6),
(239, 'Asia/Rangoon', 6),
(240, 'Asia/Riyadh', 3),
(241, 'Asia/Saigon', 7),
(242, 'Asia/Sakhalin', 10),
(243, 'Asia/Samarkand', 5),
(244, 'Asia/Seoul', 9),
(245, 'Asia/Shanghai', 8),
(246, 'Asia/Singapore', 8),
(247, 'Asia/Taipei', 8),
(248, 'Asia/Tashkent', 5),
(249, 'Asia/Tbilisi', 4),
(250, 'Asia/Tehran', 3),
(251, 'Asia/Thimphu', 6),
(252, 'Asia/Tokyo', 9),
(253, 'Asia/Ulaanbaatar', 8),
(254, 'Asia/Urumqi', 8),
(255, 'Asia/Vientiane', 7),
(256, 'Asia/Vladivostok', 10),
(257, 'Asia/Yakutsk', 9),
(258, 'Asia/Yekaterinburg', 5),
(259, 'Asia/Yerevan', 4),
(260, 'Atlantic/Azores', -1),
(261, 'Atlantic/Bermuda', -4),
(262, 'Atlantic/Canary', 0),
(263, 'Atlantic/Cape_Verde', -1),
(264, 'Atlantic/Faeroe', 0),
(265, 'Atlantic/Madeira', 0),
(266, 'Atlantic/Reykjavik', 0),
(267, 'Atlantic/South_Georgia', -2),
(268, 'Atlantic/St_Helena', 0),
(269, 'Atlantic/Stanley', -3),
(270, 'Australia/Adelaide', 10),
(271, 'Australia/Brisbane', 10),
(272, 'Australia/Broken_Hill', 10),
(273, 'Australia/Currie', 11),
(274, 'Australia/Darwin', 9),
(275, 'Australia/Hobart', 11),
(276, 'Australia/Lindeman', 10),
(277, 'Australia/Lord_Howe', 11),
(278, 'Australia/Melbourne', 11),
(279, 'Australia/Perth', 8),
(280, 'Australia/Sydney', 11),
(281, 'Europe/Amsterdam', 1),
(282, 'Europe/Andorra', 1),
(283, 'Europe/Athens', 2),
(284, 'Europe/Belgrade', 1),
(285, 'Europe/Berlin', 1),
(286, 'Europe/Brussels', 1),
(287, 'Europe/Bucharest', 2),
(288, 'Europe/Budapest', 1),
(289, 'Europe/Chisinau', 2),
(290, 'Europe/Copenhagen', 1),
(291, 'Europe/Dublin', 0),
(292, 'Europe/Gibraltar', 1),
(293, 'Europe/Helsinki', 2),
(294, 'Europe/Istanbul', 2),
(295, 'Europe/Kaliningrad', 2),
(296, 'Europe/Kiev', 2),
(297, 'Europe/Lisbon', 0),
(298, 'Europe/London', 0),
(299, 'Europe/Luxembourg', 1),
(300, 'Europe/Madrid', 1),
(301, 'Europe/Malta', 1),
(302, 'Europe/Minsk', 2),
(303, 'Europe/Monaco', 1),
(304, 'Europe/Moscow', 3),
(305, 'Europe/Oslo', 1),
(306, 'Europe/Paris', 1),
(307, 'Europe/Prague', 1),
(308, 'Europe/Riga', 2),
(309, 'Europe/Rome', 1),
(310, 'Europe/Samara', 4),
(311, 'Europe/Simferopol', 2),
(312, 'Europe/Sofia', 2),
(313, 'Europe/Stockholm', 1),
(314, 'Europe/Tallinn', 2),
(315, 'Europe/Tirane', 1),
(316, 'Europe/Uzhgorod', 2),
(317, 'Europe/Vaduz', 1),
(318, 'Europe/Vienna', 1),
(319, 'Europe/Vilnius', 2),
(320, 'Europe/Warsaw', 1),
(321, 'Europe/Zaporozhye', 2),
(322, 'Europe/Zurich', 1),
(323, 'Indian/Antananarivo', 3),
(324, 'Indian/Chagos', 6),
(325, 'Indian/Christmas', 7),
(326, 'Indian/Cocos', 6),
(327, 'Indian/Comoro', 3),
(328, 'Indian/Kerguelen', 5),
(329, 'Indian/Mahe', 4),
(330, 'Indian/Maldives', 5),
(331, 'Indian/Mauritius', 4),
(332, 'Indian/Mayotte', 3),
(333, 'Indian/Reunion', 4),
(334, 'Pacific/Apia', -11),
(335, 'Pacific/Auckland', 13),
(336, 'Pacific/Chatham', 13),
(337, 'Pacific/Easter', -5),
(338, 'Pacific/Efate', 11),
(339, 'Pacific/Enderbury', 13),
(340, 'Pacific/Fakaofo', -10),
(341, 'Pacific/Fiji', 12),
(342, 'Pacific/Funafuti', 12),
(343, 'Pacific/Galapagos', -6),
(344, 'Pacific/Gambier', -9),
(345, 'Pacific/Guadalcanal', 11),
(346, 'Pacific/Guam', 10),
(347, 'Pacific/Honolulu', -10),
(348, 'Pacific/Johnston', -10),
(349, 'Pacific/Kiritimati', 14),
(350, 'Pacific/Kosrae', 11),
(351, 'Pacific/Kwajalein', 12),
(352, 'Pacific/Majuro', 12),
(353, 'Pacific/Marquesas', -9),
(354, 'Pacific/Midway', -11),
(355, 'Pacific/Nauru', 12),
(356, 'Pacific/Niue', -11),
(357, 'Pacific/Norfolk', 11),
(358, 'Pacific/Noumea', 11),
(359, 'Pacific/Pago_Pago', -11),
(360, 'Pacific/Palau', 9),
(361, 'Pacific/Pitcairn', -8),
(362, 'Pacific/Ponape', 11),
(363, 'Pacific/Port_Moresby', 10),
(364, 'Pacific/Rarotonga', -10),
(365, 'Pacific/Saipan', 10),
(366, 'Pacific/Tahiti', -10),
(367, 'Pacific/Tarawa', 12),
(368, 'Pacific/Tongatapu', 13),
(369, 'Pacific/Truk', 10),
(370, 'Pacific/Wake', 12),
(371, 'Pacific/Wallis', 12),
(372, 'GMT', 0);

CREATE TABLE IF NOT EXISTS `tmp_active` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notify_id` bigint(20) NOT NULL,
  `command_id` int(11) DEFAULT NULL,
  `dest` varchar(255) DEFAULT NULL,
  `from_user` varchar(255) DEFAULT NULL,
  `time_string` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `notify_cmd` varchar(255) DEFAULT NULL,
  `retries` int(11) DEFAULT '0',
  `rule` int(11) DEFAULT '0',
  `progress` tinyint(1) DEFAULT '0',
  `esc_flag` tinyint(1) DEFAULT '0',
  `bundled` bigint(20) DEFAULT '0',
  `stime` int(11) DEFAULT '0',
  UNIQUE KEY `id` (`id`),
  KEY `command_id` (`command_id`),
  KEY `notify_id` (`notify_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

CREATE TABLE IF NOT EXISTS `tmp_commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation` varchar(255) DEFAULT NULL,
  `external_id` bigint(20) NOT NULL,
  `recipients` varchar(255) NOT NULL,
  `host` varchar(255) DEFAULT NULL,
  `host_alias` varchar(255) DEFAULT NULL,
  `host_address` varchar(255) DEFAULT NULL,
  `hostgroups` varchar(255) NOT NULL,
  `service` varchar(255) DEFAULT NULL,
  `servicegroups` varchar(255) DEFAULT NULL,
  `check_type` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `stime` int(11) DEFAULT '0',
  `notification_type` varchar(255) DEFAULT NULL,
  `authors` varchar(255) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `output` varchar(4096) DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `external_id` (`external_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

ALTER TABLE `tmp_active`
  ADD CONSTRAINT `tmp_active_ibfk_1` FOREIGN KEY (`command_id`) REFERENCES `tmp_commands` (`id`) ON DELETE CASCADE;
