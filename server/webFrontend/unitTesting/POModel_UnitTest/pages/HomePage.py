import sys
import time
from POModel_UnitTest.page_id import Mouthpiece_ID
from POModel_UnitTest.pages.Login import Login
import os
import time
from selenium.webdriver.common.by import By


sys.path.append(os.path.join(os.path.dirname(__file__), "..", ".."))
from selenium import webdriver


class HomePage:
    def __init__(self, driver):
        self.driver = driver

    def test_Login(self):
        obj_login = Login(self.driver)
        time.sleep(2)
        obj_login.enter_email()
        time.sleep(2)
        obj_login.enter_password()
        time.sleep(2)
        obj_login.click()
        time.sleep(2)

    def homepage_tst_seach_bar(self):
        self.driver.find_element_by_id(Mouthpiece_ID.search_id).send_keys("black")
        self.driver.find_element_by_id(Mouthpiece_ID.search_button).click()
        time.sleep(3)
        self.driver.find_element_by_id(Mouthpiece_ID.search_id).clear()
        time.sleep(2)
        self.driver.find_element_by_id(Mouthpiece_ID.search_id).send_keys("red")
        self.driver.find_element_by_id(Mouthpiece_ID.search_button).click()
        time.sleep(3)

    def home_page_link(self):
       # self.driver.find_element_by_id("sort").click()
       # time.sleep(3)
       # self.driver.find_element_by_id("pop").click()
       # time.sleep(2)
        #self.driver.find_element_by_id(Mouthpiece_ID.user).click()
        #time.sleep(3)
        #self.driver.find_element_by_id(Mouthpiece_ID.updateUsername).click()
        #time.sleep(3)
        #self.driver.find_element_by_id("username-inp").send_keys("Premo")
        #time.sleep(2)
        #self.driver.find_element_by_class_name("btn").click()
        #time.sleep(2)
        #self.driver.find_element_by_id(Mouthpiece_ID.updateEmail).click()
        #time.sleep(3)
        #self.driver.find_element_by_id("email-inp").send_keys("webteam@test.com")
       # time.sleep(2)
        #self.driver.find_element_by_class_name("btn").click()
        #time.sleep(3)
        #self.driver.find_element_by_id(Mouthpiece_ID.updatePassword).click()
        #time.sleep(3)
       # self.driver.find_element_by_id("npassword-inp").send_keys("password")
        #self.driver.find_element_by_id("cpassword-inp").send_keys("password")
        #time.sleep(3)
        #self.driver.find_element_by_class_name("btn").click()
        #time.sleep(3)

        self.driver.find_element_by_link_text('Upload').click()
        time.sleep(3)
        self.driver.back()
        time.sleep(3)
        self.driver.find_element_by_link_text('Collections').click()
        time.sleep(3)
        self.driver.back()

    def home_page_buttons(self):
        self.driver.find_element_by_id("theme_toggler").click()
        time.sleep(3)
        self.driver.find_element_by_class_name("collection-btn").click()
        time.sleep(5)
        self.driver.find_element_by_link_text('Collections').click()
        time.sleep(5)
        self.driver.find_element_by_class_name("d-block").click()
        time.sleep(3)

    def home_page_download(self):
        self.driver.find_element_by_id("downloadButton").click()
        time.sleep(3)

    def home_page_back(self):
        self.driver.find_element_by_id("backButton").click()
        time.sleep(3)

    def home_page_remove(self):
        self.driver.find_element_by_id("collection-btn").click()
        time.sleep(3)
        self.driver.find_element_by_link_text('Explore').click()
        time.sleep(3)

    def home_page_monster(self):
        self.driver.find_element_by_link_text('#Monster').click()
        time.sleep(3)

    def home_page_funny(self):
        self.driver.find_element_by_link_text('#Funny').click()
        time.sleep(3)

    def home_page_random(self):
        self.driver.find_element_by_link_text('#Random').click()
        time.sleep(3)

    def home_page_robots(self):
        self.driver.find_element_by_link_text('#Robots').click()
        time.sleep(3)

    def home_page_animals(self):
        self.driver.find_element_by_link_text('#Animals').click()
        time.sleep(3)

    def home_page_all(self):
        self.driver.find_element_by_link_text('#All').click()
        time.sleep(3)

    def home_page_newest(self):
        self.driver.find_element_by_class_name('dropdown-toggle ').click()
        time.sleep(3)
        self.driver.find_element_by_link_text('Newest').click()
        time.sleep(3)

    def home_page_top(self):
        self.driver.find_element_by_class_name('dropdown-toggle ').click()
        time.sleep(3)
        self.driver.find_element_by_link_text('Top Rated').click()
        time.sleep(3)

    def home_page_oldest(self):
        self.driver.find_element_by_class_name('dropdown-toggle ').click()
        time.sleep(3)
        self.driver.find_element_by_link_text('Oldest').click()
        time.sleep(3)

    def home_page_low(self):
        self.driver.find_element_by_class_name('dropdown-toggle ').click()
        time.sleep(3)
        self.driver.find_element_by_link_text('Lowest Rated').click()
        time.sleep(3)

