#
# 1.0.6 to 1.0.7
#
IF NOT EXISTS (SELECT  * FROM noma.COLUMNS
WHERE TABLE_NAME='escalation_stati' AND column_name='hostgroups')
BEGIN
ALTER TABLE `escalation_stati` ADD `hostgroups` VARCHAR( 255 ) NOT NULL AFTER `hostgroups`
ALTER TABLE `escalation_stati` ADD `servicegroups` VARCHAR( 255 ) NOT NULL AFTER `service`
ALTER TABLE `tmp_commands` ADD `servicegroups` VARCHAR( 255 ) NOT NULL AFTER `service`
ALTER TABLE `notifications` ADD `servicegroups_include` VARCHAR( 255 ) NOT NULL AFTER `services_exclude`
ALTER TABLE `notifications` ADD `servicegroups_exclude` VARCHAR( 255 ) NOT NULL AFTER `servicegroups_include`
ALTER TABLE `notifications` ADD `hostgroups` VARCHAR( 255 ) NOT NULL AFTER `hosts_exclude`
ALTER TABLE `notifications` ADD `hostgroups` VARCHAR( 255 ) NOT NULL AFTER `hostgroups_include`
END

ALTER TABLE `tmp_commands` ADD `authors` varchar(255) NOT NULL AFTER `notification_type`
ALTER TABLE `tmp_commands` ADD `comments` varchar(255) NOT NULL AFTER `authors`
ALTER TABLE `escalation_stati` ADD `recipients` VARCHAR( 255 ) NOT NULL AFTER `incident_id`;
ALTER TABLE `tmp_commands` ADD `recipients` VARCHAR( 255 ) NOT NULL AFTER `external_id`;
ALTER TABLE `notifications` ADD `recipients_include` VARCHAR( 255 ) NOT NULL AFTER `username`;
ALTER TABLE `notifications` ADD `recipients_exclude` VARCHAR( 255 ) NOT NULL AFTER `recipients_include`;

CREATE INDEX external_id ON tmp_commands (external_id);
CREATE INDEX unique_id ON notification_logs (unique_id);
CREATE INDEX notify_id ON tmp_active (notify_id);
CREATE INDEX incident_id ON escalation_stati (incident_id);

CREATE INDEX contactgroup_id ON contactgroups_to_contacts (contactgroup_id);
CREATE INDEX contact_id ON contactgroups_to_contacts (contact_id);

CREATE INDEX escalation_contacts_id ON escalations_contacts_to_contacts (escalation_contacts_id);
CREATE INDEX contactgroup_id ON escalations_contacts_to_contactgroups (contactgroup_id);
CREATE INDEX escalation_contacts_id ON escalations_contacts_to_contacts (escalation_contacts_id);
CREATE INDEX contacts_id ON escalations_contacts_to_contacts (contacts_id);
CREATE INDEX escalation_contacts_id ON escalations_contacts_to_methods (escalation_contacts_id);
CREATE INDEX method_id ON escalations_contacts_to_methods (method_id);

CREATE INDEX notification_id ON notifications_to_contacts (notification_id);
CREATE INDEX contactgroup_id ON notifications_to_contactgroups (contactgroup_id);
CREATE INDEX notification_id ON notifications_to_contacts (notification_id);
CREATE INDEX contact_id ON notifications_to_contacts (contact_id);
CREATE INDEX notification_id ON notifications_to_methods (notification_id);
CREATE INDEX method_id ON notifications_to_methods (method_id);

# IF not hotfixed for hostgroups after upgrade to 1.0.6, run this to be sure! (If it already exists, it wont finish!)
ALTER TABLE `tmp_commands` ADD `hostgroups` VARCHAR( 255 ) NOT NULL AFTER `hostgroups`
