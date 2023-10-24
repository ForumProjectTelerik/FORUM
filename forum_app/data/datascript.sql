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
-- -----------------------------------------------------
-- Schema forum_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema forum_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `forum_db` DEFAULT CHARACTER SET latin1 ;
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
-- Table `new_forum_project`.`conversations_between_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`conversations_between_users` (
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
AUTO_INCREMENT = 5
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
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`likes_of_post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`likes_of_post` (
  `id_of_likes` INT(11) NOT NULL AUTO_INCREMENT,
  `new_user_id_of_user` INT(11) NOT NULL,
  `new_topic_id_of_topic` INT(11) NOT NULL,
  PRIMARY KEY (`id_of_likes`),
  INDEX `fk_likes_of_post_new_user1_idx` (`new_user_id_of_user` ASC) VISIBLE,
  INDEX `fk_likes_of_post_new_topic1_idx` (`new_topic_id_of_topic` ASC) VISIBLE,
  CONSTRAINT `fk_likes_of_post_new_user1`
    FOREIGN KEY (`new_user_id_of_user`)
    REFERENCES `new_forum_project`.`new_user` (`id_of_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_likes_of_post_new_topic1`
    FOREIGN KEY (`new_topic_id_of_topic`)
    REFERENCES `new_forum_project`.`new_topic` (`id_of_topic`)
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
    REFERENCES `new_forum_project`.`conversations_between_users` (`id_of_conversations`)
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
  `new_topic_id_of_topic` INT(11) NOT NULL,
  `new_user_id_of_user` INT(11) NOT NULL,
  PRIMARY KEY (`id_of_replies`),
  INDEX `fk_replies_new_topic1_idx` (`new_topic_id_of_topic` ASC) VISIBLE,
  INDEX `fk_replies_new_user1_idx` (`new_user_id_of_user` ASC) VISIBLE,
  CONSTRAINT `fk_replies_new_topic1`
    FOREIGN KEY (`new_topic_id_of_topic`)
    REFERENCES `new_forum_project`.`new_topic` (`id_of_topic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_replies_new_user1`
    FOREIGN KEY (`new_user_id_of_user`)
    REFERENCES `new_forum_project`.`new_user` (`id_of_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_forum_project`.`conversations_between_users_has_replies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_forum_project`.`conversations_between_users_has_replies` (
  `conversations_between_users_id_of_conversations` INT(11) NOT NULL,
  `replies_id_of_replies` INT(11) NOT NULL,
  PRIMARY KEY (`conversations_between_users_id_of_conversations`, `replies_id_of_replies`),
  INDEX `fk_conversations_between_users_has_replies_replies1_idx` (`replies_id_of_replies` ASC) VISIBLE,
  INDEX `fk_conversations_between_users_has_replies_conversations_be_idx` (`conversations_between_users_id_of_conversations` ASC) VISIBLE,
  CONSTRAINT `fk_conversations_between_users_has_replies_conversations_betw`
    FOREIGN KEY (`conversations_between_users_id_of_conversations`)
    REFERENCES `new_forum_project`.`conversations_between_users` (`id_of_conversations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conversations_between_users_has_replies_replies1`
    FOREIGN KEY (`replies_id_of_replies`)
    REFERENCES `new_forum_project`.`replies` (`id_of_replies`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `forum_db` ;

-- -----------------------------------------------------
-- Table `forum_db`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_db`.`category` (
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forum_db`.`conversations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_db`.`conversations` (
  `convo_id` INT(11) NOT NULL AUTO_INCREMENT,
  `receiver_username` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`convo_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forum_db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_db`.`user` (
  `idUser` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `nickname` VARCHAR(20) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `dateOfBirth` DATE NOT NULL,
  `gender` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forum_db`.`topic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_db`.`topic` (
  `idTopic` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `dateOfCreation` DATETIME NOT NULL,
  `author_id` INT(11) NOT NULL,
  `category_name` VARCHAR(20) NOT NULL,
  `likes_count` INT(11) NOT NULL,
  `topic_text` LONGTEXT NOT NULL,
  PRIMARY KEY (`idTopic`),
  INDEX `fk_topic_user1_idx` (`author_id` ASC) VISIBLE,
  INDEX `fk_topic_category1_idx` (`category_name` ASC) VISIBLE,
  CONSTRAINT `fk_topic_category1`
    FOREIGN KEY (`category_name`)
    REFERENCES `forum_db`.`category` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_topic_user1`
    FOREIGN KEY (`author_id`)
    REFERENCES `forum_db`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forum_db`.`likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_db`.`likes` (
  `idLikes` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `topic_id` INT(11) NOT NULL,
  PRIMARY KEY (`idLikes`),
  INDEX `fk_likes_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_likes_topic1_idx` (`topic_id` ASC) VISIBLE,
  CONSTRAINT `fk_likes_topic1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `forum_db`.`topic` (`idTopic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_likes_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `forum_db`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forum_db`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_db`.`messages` (
  `idMessages` INT(11) NOT NULL AUTO_INCREMENT,
  `messageText` TEXT NOT NULL,
  `sender_id` INT(11) NOT NULL,
  `to_this_convo_id` INT(11) NOT NULL,
  PRIMARY KEY (`idMessages`),
  INDEX `fk_messages_user1_idx` (`sender_id` ASC) VISIBLE,
  INDEX `fk_messages_conversations1_idx` (`to_this_convo_id` ASC) VISIBLE,
  CONSTRAINT `fk_messages_conversations1`
    FOREIGN KEY (`to_this_convo_id`)
    REFERENCES `forum_db`.`conversations` (`convo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_user1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `forum_db`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forum_db`.`replies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_db`.`replies` (
  `idReplies` INT(11) NOT NULL AUTO_INCREMENT,
  `text` TEXT NOT NULL,
  `user_id` INT(11) NOT NULL,
  `topic_id` INT(11) NOT NULL,
  PRIMARY KEY (`idReplies`),
  INDEX `fk_replies_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_replies_topic1_idx` (`topic_id` ASC) VISIBLE,
  CONSTRAINT `fk_replies_topic1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `forum_db`.`topic` (`idTopic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_replies_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `forum_db`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `forum_db`.`user_has_conversations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_db`.`user_has_conversations` (
  `user_idUser` INT(11) NOT NULL,
  `conversations_idConversations` INT(11) NOT NULL,
  PRIMARY KEY (`user_idUser`, `conversations_idConversations`),
  INDEX `fk_user_has_conversations_conversations1_idx` (`conversations_idConversations` ASC) VISIBLE,
  INDEX `fk_user_has_conversations_user1_idx` (`user_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_conversations_conversations1`
    FOREIGN KEY (`conversations_idConversations`)
    REFERENCES `forum_db`.`conversations` (`convo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_conversations_user1`
    FOREIGN KEY (`user_idUser`)
    REFERENCES `forum_db`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
