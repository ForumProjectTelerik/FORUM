-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema new_forum_project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema new_forum_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `new_forum_project` DEFAULT CHARACTER SET latin1 ;
USE `new_forum_project` ;

-- -----------------------------------------------------
-- Table `new_forum_project`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`category` (
  `name_of_category` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`name_of_category`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`conversations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`conversations` (
  `id_of_conversations` INT(11) NOT NULL AUTO_INCREMENT,
  `owner_of_conversation` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id_of_conversations`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`new_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`new_user` (
  `id_of_user` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(60) NOT NULL,
  `nickname` VARCHAR(40) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `gender` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_of_user`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`new_topic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`new_topic` (
  `id_of_topic` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `topic_text` VARCHAR(50) NOT NULL,
  `date_of_creation` DATETIME NOT NULL,
  `category_name_of_category` VARCHAR(25) NOT NULL,
  `id_of_author` INT(11) NOT NULL,
  PRIMARY KEY (`id_of_topic`),
  INDEX `fk_new_topic_category1_idx` (`category_name_of_category` ASC) VISIBLE,
  INDEX `fk_new_topic_new_user1_idx` (`id_of_author` ASC) VISIBLE,
  CONSTRAINT `fk_new_topic_category1`
    FOREIGN KEY (`category_name_of_category`)
    REFERENCES `new_forum_project`.`category` (`name_of_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new_topic_new_user1`
    FOREIGN KEY (`id_of_author`)
    REFERENCES `new_forum_project`.`new_user` (`id_of_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`reactions_of_post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`reactions_of_post` (
  `id_of_likes` INT(11) NOT NULL AUTO_INCREMENT,
  `new_user_id` INT(11) NOT NULL,
  `new_topic_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_of_likes`),
  INDEX `fk_likes_of_post_new_user1_idx` (`new_user_id` ASC) VISIBLE,
  INDEX `fk_likes_of_post_new_topic1_idx` (`new_topic_id` ASC) VISIBLE,
  CONSTRAINT `fk_likes_of_post_new_topic1`
    FOREIGN KEY (`new_topic_id`)
    REFERENCES `new_forum_project`.`new_topic` (`id_of_topic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_likes_of_post_new_user1`
    FOREIGN KEY (`new_user_id`)
    REFERENCES `new_forum_project`.`new_user` (`id_of_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`messages` (
  `id_of_messages` INT(11) NOT NULL AUTO_INCREMENT,
  `text_message` TEXT NOT NULL,
  `conversations_between_users_id_of_conversations` INT(11) NOT NULL,
  `new_user_id_of_user` INT(11) NOT NULL,
  PRIMARY KEY (`id_of_messages`),
  INDEX `fk_messages_conversations_between_users1_idx` (`conversations_between_users_id_of_conversations` ASC) VISIBLE,
  INDEX `fk_messages_new_user1_idx` (`new_user_id_of_user` ASC) VISIBLE,
  CONSTRAINT `fk_messages_conversations_between_users1`
    FOREIGN KEY (`conversations_between_users_id_of_conversations`)
    REFERENCES `new_forum_project`.`conversations` (`id_of_conversations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_new_user1`
    FOREIGN KEY (`new_user_id_of_user`)
    REFERENCES `new_forum_project`.`new_user` (`id_of_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`replies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`replies` (
  `id_of_replies` INT(11) NOT NULL AUTO_INCREMENT,
  `text` TEXT NOT NULL,
  `new_topic_id` INT(11) NOT NULL,
  `new_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_of_replies`),
  INDEX `fk_replies_new_topic1_idx` (`new_topic_id` ASC) VISIBLE,
  INDEX `fk_replies_new_user1_idx` (`new_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_replies_new_topic1`
    FOREIGN KEY (`new_topic_id`)
    REFERENCES `new_forum_project`.`new_topic` (`id_of_topic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_replies_new_user1`
    FOREIGN KEY (`new_user_id`)
    REFERENCES `new_forum_project`.`new_user` (`id_of_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`conversations_between_new_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`conversations_between_new_users` (
  `convo_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`convo_id`, `user_id`),
  INDEX `fk_conversations_between_users_has_new_user_new_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_conversations_between_users_has_new_user_conversations_b_idx` (`convo_id` ASC) VISIBLE,
  CONSTRAINT `fk_conversations_between_users_has_new_user_conversations_bet1`
    FOREIGN KEY (`convo_id`)
    REFERENCES `new_forum_project`.`conversations` (`id_of_conversations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conversations_between_users_has_new_user_new_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `new_forum_project`.`new_user` (`id_of_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

