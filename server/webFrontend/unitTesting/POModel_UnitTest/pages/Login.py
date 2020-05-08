import sys

from POModel_UnitTest.page_id import Mouthpiece_ID
import os
import time

sys.path.append(os.path.join(os.path.dirname(__file__), "..", ".."))
from selenium import webdriver


class Login:
    def __init__(self, driver):
        self.email = "webteam@test.com"
        self.invalid_email = "invalid@test.com"
        self.password = "p@sswOrd0123"
        self.username = "Tshegofatso"
        self.driver = driver

    def register_emptyField(self):
        self.driver.find_element_by_id("R_username").clear()
        self.driver.find_element_by_id("R_username").send_keys()
        time.sleep(1)
        self.driver.find_element_by_id("R_email").clear()
        self.driver.find_element_by_id("R_email").send_keys()
        time.sleep(1)
        self.driver.find_element_by_id("R_password").clear()
        self.driver.find_element_by_id("R_password").send_keys()
        time.sleep(2)
        self.driver.find_element_by_id("R_bottomnextup3").click()
        time.sleep(2)

    def register_emptyUsererName(self):
        self.driver.find_element_by_id("R_username").clear()
        self.driver.find_element_by_id("R_username").send_keys()
        time.sleep(1)
        self.driver.find_element_by_id("R_email").clear()
        self.driver.find_element_by_id("R_email").send_keys(self.email)
        time.sleep(1)
        self.driver.find_element_by_id("R_password").clear()
        self.driver.find_element_by_id("R_password").send_keys(self.password)
        time.sleep(2)
        self.driver.find_element_by_id("R_bottomnextup3").click()
        time.sleep(2)

    def register_emptyEmail(self):
        self.driver.find_element_by_id("R_username").clear()
        self.driver.find_element_by_id("R_username").send_keys(self.username)
        time.sleep(1)
        self.driver.find_element_by_id("R_email").clear()
        self.driver.find_element_by_id("R_email").send_keys()
        time.sleep(1)
        self.driver.find_element_by_id("R_password").clear()
        self.driver.find_element_by_id("R_password").send_keys(self.password)
        time.sleep(2)
        self.driver.find_element_by_id("R_bottomnextup3").click()
        time.sleep(2)

    def register_wrongEmail(self):
        self.driver.find_element_by_id("R_username").clear()
        self.driver.find_element_by_id("R_username").send_keys(self.username)
        time.sleep(1)
        self.driver.find_element_by_id("R_email").clear()
        self.driver.find_element_by_id("R_email").send_keys("premodial.com")
        time.sleep(1)
        self.driver.find_element_by_id("R_password").clear()
        self.driver.find_element_by_id("R_password").send_keys(self.password)
        time.sleep(2)
        self.driver.find_element_by_id("R_bottomnextup3").click()
        time.sleep(2)

    def register_wrongPassword(self):
        self.driver.find_element_by_id("R_username").clear()
        self.driver.find_element_by_id("R_username").send_keys(self.username)
        time.sleep(1)
        self.driver.find_element_by_id("R_email").clear()
        self.driver.find_element_by_id("R_email").send_keys(self.email)
        time.sleep(1)
        self.driver.find_element_by_id("R_password").clear()
        self.driver.find_element_by_id("R_password").send_keys("123")
        time.sleep(2)
        self.driver.find_element_by_id("R_bottomnextup3").click()
        time.sleep(2)

    def register(self):
        self.driver.find_element_by_id("R_username").clear()
        self.driver.find_element_by_id("R_username").send_keys(self.username)
        time.sleep(1)
        self.driver.find_element_by_id("R_email").clear()
        self.driver.find_element_by_id("R_email").send_keys(self.email)
        time.sleep(1)
        self.driver.find_element_by_id("R_password").clear()
        self.driver.find_element_by_id("R_password").send_keys(self.password)
        time.sleep(2)
        self.driver.find_element_by_id("R_bottomnextup3").click()
        time.sleep(2)

    def loginpage(self):
        self.driver.find_element_by_link_text('Login').click()

    def enter_email(self):
        self.driver.find_element_by_id(Mouthpiece_ID.email_id).clear()
        self.driver.find_element_by_id(Mouthpiece_ID.email_id).send_keys(self.email)

    def enter_non_registered_email(self):
        self.driver.find_element_by_id(Mouthpiece_ID.email_id).clear()
        self.driver.find_element_by_id(Mouthpiece_ID.email_id).send_keys(self.invalid_email)

    def enter_password(self):
        self.driver.find_element_by_id(Mouthpiece_ID.password).clear()
        self.driver.find_element_by_id(Mouthpiece_ID.password).send_keys(self.password)

    def enter_invalid_email(self):
        self.driver.find_element_by_id(Mouthpiece_ID.email_id).clear()
        self.driver.find_element_by_id(Mouthpiece_ID.email_id).send_keys()

    def enter_invalid_password(self):
        self.driver.find_element_by_id(Mouthpiece_ID.password).clear()
        self.driver.find_element_by_id(Mouthpiece_ID.password).send_keys()

    def click(self):
        self.driver.find_element_by_id(Mouthpiece_ID.button).click()

    def log_out(self):
        self.driver.back()
