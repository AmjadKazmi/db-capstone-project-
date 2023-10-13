-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Little_lemon_capstone
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema little_lemon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `little_lemon` ;

-- -----------------------------------------------------
-- Table `little_lemon`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `ContactNumber` INT NOT NULL,
  `Email` VARCHAR(100) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon`.`Staffs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`Staffs` (
  `StaffID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Role` VARCHAR(50) NOT NULL,
  `Address` VARCHAR(200) NOT NULL,
  `Contact_Number` INT NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `Annual_Salary` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NULL DEFAULT NULL,
  `BookingSlot` TIME NOT NULL,
  `CustomerID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `StaffID_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `little_lemon`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `StaffID`
    FOREIGN KEY (`StaffID`)
    REFERENCES `little_lemon`.`Staffs` (`StaffID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`MenuItems` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NULL DEFAULT NULL,
  `Type` VARCHAR(100) NULL DEFAULT NULL,
  `Price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ItemID`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`Menus` (
  `MenuID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `Cuisine` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`MenuID`, `ItemID`),
  INDEX `itemID_idx` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `itemID`
    FOREIGN KEY (`ItemID`)
    REFERENCES `little_lemon`.`MenuItems` (`ItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon`.`OrderDeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`OrderDeliveryStatus` (
  `DeiiveryID` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  `Status` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`DeiiveryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `MenuID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `BillAmount` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `StatusID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `BookingID_idx` (`BookingID` ASC) VISIBLE,
  INDEX `StatusID_idx` (`StatusID` ASC) VISIBLE,
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `little_lemon`.`Menus` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BookingID`
    FOREIGN KEY (`BookingID`)
    REFERENCES `little_lemon`.`Bookings` (`BookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `StatusID`
    FOREIGN KEY (`StatusID`)
    REFERENCES `little_lemon`.`OrderDeliveryStatus` (`DeiiveryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
