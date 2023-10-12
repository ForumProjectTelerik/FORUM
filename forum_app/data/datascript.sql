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
-- Table `new_forum_project`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`messages` (
  `id_of_messages` INT NOT NULL AUTO_INCREMENT,
  `owner_of_massage` VARCHAR(25) NOT NULL,
  `text_message` TEXT NOT NULL,
  PRIMARY KEY (`id_of_messages`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`conversations_between_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`conversations_between_users` (
  `id_of_conversations` INT NOT NULL AUTO_INCREMENT,
  `users` VARCHAR(100) NOT NULL,
  `owner_of_conversation` VARCHAR(20) NOT NULL,
  `messages_id_of_messages` INT NOT NULL,
  PRIMARY KEY (`id_of_conversations`),
  INDEX `fk_conversations_between_users_messages1_idx` (`messages_id_of_messages` ASC) VISIBLE,
  CONSTRAINT `fk_conversations_between_users_messages1`
    FOREIGN KEY (`messages_id_of_messages`)
    REFERENCES `new_forum_project`.`messages` (`id_of_messages`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`likes_of_post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`likes_of_post` (
  `id_of_likes` INT NOT NULL AUTO_INCREMENT,
  `like_of_owner` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id_of_likes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`replies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`replies` (
  `id_of_replies` INT NOT NULL AUTO_INCREMENT,
  `reply_of_owner` VARCHAR(60) NOT NULL,
  `text` TEXT NOT NULL,
  PRIMARY KEY (`id_of_replies`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`new_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`new_user` (
  `id_of_user` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `nickname` VARCHAR(20) NOT NULL,
  `password` VARCHAR(35) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `gender` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_of_user`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`new_topic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`new_topic` (
  `id_of_topic` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `topic_owner` VARCHAR(50) NOT NULL,
  `date_of_creation` DATETIME NOT NULL,
  `likes_of_post_id_of_likes` INT NOT NULL,
  `replies_id_of_replies` INT NOT NULL,
  `category_name_of_category` VARCHAR(25) NOT NULL,
  `new_user_id_of_user` INT NOT NULL,
  PRIMARY KEY (`id_of_topic`),
  INDEX `fk_new_topic_likes_of_post1_idx` (`likes_of_post_id_of_likes` ASC) VISIBLE,
  INDEX `fk_new_topic_replies1_idx` (`replies_id_of_replies` ASC) VISIBLE,
  INDEX `fk_new_topic_category1_idx` (`category_name_of_category` ASC) VISIBLE,
  INDEX `fk_new_topic_new_user1_idx` (`new_user_id_of_user` ASC) VISIBLE,
  CONSTRAINT `fk_new_topic_likes_of_post1`
    FOREIGN KEY (`likes_of_post_id_of_likes`)
    REFERENCES `new_forum_project`.`likes_of_post` (`id_of_likes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new_topic_replies1`
    FOREIGN KEY (`replies_id_of_replies`)
    REFERENCES `new_forum_project`.`replies` (`id_of_replies`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new_topic_category1`
    FOREIGN KEY (`category_name_of_category`)
    REFERENCES `new_forum_project`.`category` (`name_of_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new_topic_new_user1`
    FOREIGN KEY (`new_user_id_of_user`)
    REFERENCES `new_forum_project`.`new_user` (`id_of_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`new_user_has_conversations_between_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`new_user_has_conversations_between_users` (
  `new_user_id_of_user` INT NOT NULL,
  `conversations_between_users_id_of_conversations` INT NOT NULL,
  PRIMARY KEY (`new_user_id_of_user`, `conversations_between_users_id_of_conversations`),
  INDEX `fk_new_user_has_conversations_between_users_conversations_b_idx` (`conversations_between_users_id_of_conversations` ASC) VISIBLE,
  INDEX `fk_new_user_has_conversations_between_users_new_user1_idx` (`new_user_id_of_user` ASC) VISIBLE,
  CONSTRAINT `fk_new_user_has_conversations_between_users_new_user1`
    FOREIGN KEY (`new_user_id_of_user`)
    REFERENCES `new_forum_project`.`new_user` (`id_of_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new_user_has_conversations_between_users_conversations_bet1`
    FOREIGN KEY (`conversations_between_users_id_of_conversations`)
    REFERENCES `new_forum_project`.`conversations_between_users` (`id_of_conversations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;