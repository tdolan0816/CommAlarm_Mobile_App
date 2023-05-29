from typing import Any
from kivy.lang import Builder
from kivy.uix.slider import Slider
from kivy.storage.jsonstore import JsonStore
from glom import glom
from kivymd.app import MDApp
from kivy.core.window import Window
from kivymd.uix.screen import Screen
from kivymd.uix.textfield import MDTextField
from kivymd.uix.screen import MDScreen
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.screenmanager import Screen, ScreenManager
from kivy.uix.scrollview import ScrollView
from kivy.uix.image import Image
from kivy.clock import Clock
from kivy.app import App
from kivy.uix.widget import Widget
from kivy.uix.label import Label
from kivy.uix.boxlayout import BoxLayout
from kivymd.uix.boxlayout import MDBoxLayout
from kivymd.uix.tab import MDTabsBase
from kivymd.icon_definitions import md_icons
from kivymd.uix.fitimage import FitImage
from kivymd.uix.dialog import MDDialog
from kivymd.uix.button import MDFlatButton
from kivy.uix.popup import Popup
import googlemaps
from datetime import datetime as dt
from datetime import timedelta
import kivy.utils
import kivy
from kivy.properties import ObjectProperty
from kivy.uix.button import Button
import googlemaps as gmaps
import datetime
import requests
import time
from playsound import playsound
import playsound
import threading
from kivymd.uix.pickers import MDDatePicker
from kivymd.uix.dialog import dialog
from kivymd.uix.floatlayout import MDFloatLayout
from kivymd.uix.pickers import MDTimePicker


# KivyMD Widgets and Screens
Window.size=(345,610)

# Animation of Logo Screen
class OpenScreen(Screen):
    def on_enter(self, *args):
        Clock.schedule_once(self.switch_to_home, 8)

    def switch_to_home(self, dt):
        self.manager.current = 'MenuScreen'

class MenuScreen(Screen):
    pass

class Freq_Screen(Screen):

    def on_save_date(self, instance, value, date_range):
        self.ids.start_date_output.text = str(date_range[0])
        self.ids.end_date_output.text = str(date_range[-1])
    
    def on_cancel_date(self, instance, value):
        instance.dismiss()
        

    def show_date_picker(self):
        date_dialog = MDDatePicker(mode = "range")
        date_dialog.bind(on_save=self.on_save_date, on_cancel=self.on_cancel_date)
        date_dialog.open()

    def f_no_enddate_ckbx_input(self, instance, value, end_date_output):
        end_date_output = self.ids.end_date_output
        start_date_output = self.ids.start_date_output
        if value and end_date_output.text == start_date_output.text:
            end_date_output.text = "No End Date"
        else:
            end_date_output.text = ""

    #  Frequency Checkbox Functions for Weekdays
    def freq_chckbox_wkdays(self, instance, value, freq_wkdays_ckbx_output):
        freq_wkdays_ckbx_output = self.ids.freq_wkdays_ckbx_output
        if value:
            freq_wkdays_ckbx_output.text = "Weekdays"
        else:
            freq_wkdays_ckbx_output.text = ""

        # Frequency Checkbox Functions for Weekends
    def freq_chckbox_wkends(self, instance, value, freq_wkdays_ckbx_output):
        freq_wkdays_ckbx_output = self.ids.freq_wkdays_ckbx_output
        if value:
            freq_wkdays_ckbx_output.text = "Weekends"
        else:
            freq_wkdays_ckbx_output.text = ""

    # Frequency Checkbox Functions for Full Week
    def freq_chckbox_fullwk(self, instance, value, freq_fullwk_ckbx_output):
        freq_fullwk_ckbx_output = self.ids.freq_fullwk_ckbx_output
        if value:
            freq_fullwk_ckbx_output.text = "All Week"
        else:
            freq_fullwk_ckbx_output.text = ""
    
    def start_date_move(self):
        start_date = self.ids.start_date_output.text
        self.manager.get_screen('Review_Popup').ids.start_date_input.text = start_date

    def end_date_move(self):
        end_date = self.ids.end_date_output.text
        self.manager.get_screen('Review_Popup').ids.end_date_input.text = end_date

    def freq_wkday_move(self):
        freq_weekdays = self.ids.freq_wkdays_ckbx_output.text
        self.manager.get_screen('Review_Popup').ids.freq_input_label.text = freq_weekdays

    def freq_wkend_move(self):
        freq_weekends = self.ids.freq_wkdays_ckbx_output.text
        self.manager.get_screen('Review_Popup').ids.freq_input_label.text = freq_weekends

    def freq_fullwk_move(self):
        freq_fullwk = self.ids.freq_fullwk_ckbx_output.text
        self.manager.get_screen('Review_Popup').ids.freq_input_label.text = freq_fullwk

   
class TS_Popup(Screen):

    def a_get_time(self, instance, time):
        self.ids.alarm_time_output.text = str(time)

    def a_on_cancel_time(self, instance, time):
        instance.dismiss()

    def a_time_picker_open(self):
        time_dialog = MDTimePicker()
        time_dialog.bind(time = self.a_get_time, on_cancel=self.a_on_cancel_time)
        time_dialog.open()
    
    def r_get_time(self, instance, time):
        self.ids.ready_time_output.text = str(time)
    
    def r_on_cancel_time(self, instance, time):
        instance.dismiss()

    def r_time_picker_open(self):
        time_dialog = MDTimePicker()
        time_dialog.bind(time = self.r_get_time, on_cancel=self.r_on_cancel_time)
        time_dialog.open()

    def arrvl_get_time(self, instance, time):
        self.ids.arrvl_time_output.text = str(time)
    
    def arrvl_on_cancel_time(self, instance, time):
        instance.dismiss()

    def arrvl_time_picker_open(self):
        time_dialog = MDTimePicker()
        time_dialog.bind(time = self.arrvl_get_time, on_cancel=self.arrvl_on_cancel_time)
        time_dialog.open()


    # Alarm Time Input Function to Move Data to Review Screen
    def alarm_time_output(self):
        time_input = self.ids.alarm_time_output.text
        self.manager.get_screen('Review_Popup').ids.time_input_label.text = time_input
        self.manager.get_screen('Calc_Screen').ids.alarm_time_input.text = time_input

    # Arrival Time Input Function to Move Data to Review Screen
    def arrvl_time_output(self):
        arrvl_time_output = self.ids.arrvl_time_output.text
        self.manager.get_screen('Review_Popup').ids.arrvl_input_label.text = arrvl_time_output
        self.manager.get_screen('Calc_Screen').ids.arrvl_time_input.text = arrvl_time_output

    # Ready Time Input Function to Move Data to Review Screen
    def ready_time_output(self):
        ready_time = self.ids.ready_time_output.text
        self.manager.get_screen('Review_Popup').ids.ready_input_label.text = ready_time
        self.manager.get_screen('Calc_Screen').ids.ready_time_input.text = ready_time

class Start_Popup(Screen):    

    # Output from Origin Address Window 
    def add_input_move(self):
        stadd_txt_field = self.ids.stadd_txt_field.text
        self.manager.get_screen('Review_Popup').ids.add_output_label.text = stadd_txt_field
        
    def city_input_move(self):
        city_txt_field = self.ids.city_txt_field.text
        self.manager.get_screen('Review_Popup').ids.city_output_label.text = city_txt_field    

    def state_input_move(self):
        state_txt_field = self.ids.state_txt_field.text
        self.manager.get_screen('Review_Popup').ids.state_output_label.text = state_txt_field

    def zip_input_move(self):
        zip_txt_field = self.ids.zip_txt_field.text
        self.manager.get_screen('Review_Popup').ids.zip_output_label.text = zip_txt_field

class End_Popup(Screen):

    def e_add_input_move(self):
        e_stadd_txt_field = self.ids.e_stadd_txt_field.text
        self.manager.get_screen('Review_Popup').ids.e_add_output_label.text = e_stadd_txt_field
        
    def e_city_input_move(self):
        e_city_txt_field = self.ids.e_city_txt_field.text
        self.manager.get_screen('Review_Popup').ids.e_city_output_label.text = e_city_txt_field    

    def e_state_input_move(self):
        e_state_txt_field = self.ids.e_state_txt_field.text
        self.manager.get_screen('Review_Popup').ids.e_state_output_label.text = e_state_txt_field

    def e_zip_input_move(self):
        e_zip_txt_field = self.ids.e_zip_txt_field.text
        self.manager.get_screen('Review_Popup').ids.e_zip_output_label.text = e_zip_txt_field


class Review_Popup(Screen):

    def origin(self):
        start_add = self.ids.add_output_label.text
        start_add = start_add.replace(" ", "")
        start_city = self.ids.city_output_label.text
        start_city = (f'%2C{start_city}%2C')
        start_state = self.ids.state_output_label.text
        start_loc = (f'{start_add}{start_city}{start_state}')
        # print(start_loc)
        return start_loc
    
    def dest(self):
        end_add = self.ids.e_add_output_label.text
        end_add = end_add.replace(" ", "")
        end_city = self.ids.e_city_output_label.text
        end_city = (f'%2C{end_city}%2C')
        end_state = self.ids.e_state_output_label.text
        end_loc = (f'{end_add}{end_city}{end_state}')
        # print(end_loc)
        return end_loc
    
    def calc_travel_time(self):
         results = self.process_data()
         self.manager.get_screen('Calc_Screen').ids.comm_time_input.text = results
    
    start_data = ""
    end_data = ""

    def process_data(self):
        start_data = self.origin()
        end_data = self.dest()
        url = f"https://maps.googleapis.com/maps/api/distancematrix/json?origins={start_data}&destinations={end_data}&departure_time=now&key=AIzaSyAt3cfWb_B_ZYY1mkFeQK8S855C88ZvUQ4"
        payload={}
        headers = {}
        response = requests.request("GET", url, headers=headers, data=payload)
        response.json()
        duration_in_traffic = glom(response.json(), 'rows.0.elements.0.duration_in_traffic.text')
        return duration_in_traffic

        
class Calc_Screen(Screen):

    def comm_time_final(self):
        comm_time_final1 = self.comm_time_format1()
        self.ids.fcomm_time_input.text = comm_time_final1
        print(comm_time_final1)

    def comm_time_format1(self):
        comm_time = self.ids.comm_time_input.text
        comm_time = comm_time.replace(" ", "")
        comm_time = comm_time.replace("hour",":")
        comm_time = comm_time.replace("mins","")
        return comm_time

    def new_alarm_time_final(self):
        new_alarm_time_final1 = self.new_alarm_time()
        self.ids.new_alarm_input.text = new_alarm_time_final1
        print(new_alarm_time_final1)
   
    # function to calculate new alarm time based on commute time, ready time, and arrival time
    def new_alarm_time(self):
        alarm_time = datetime.datetime.strptime(self.ids.alarm_time_input.text, '%H:%M:%S')
        ready_time = datetime.datetime.strptime(self.ids.ready_time_input.text, '%H:%M') # type: ignore
        comm_time = datetime.datetime.strptime(self.ids.fcomm_time_input.text, '%H:%M') # type: ignore
        arrvl_time = datetime.datetime.strptime(self.ids.arrvl_time_input.text, '%H:%M:%S') # type: ignore

        calc_alarm_time = timedelta(hours=alarm_time.hour, minutes=alarm_time.minute)
        calc_ready_time = timedelta(hours=ready_time.hour, minutes=ready_time.minute)
        calc_comm_time = timedelta(hours=comm_time.hour, minutes=comm_time.minute)
        calc_arrvl_time = timedelta(hours=arrvl_time.hour, minutes=arrvl_time.minute)

        if calc_alarm_time + calc_ready_time + calc_comm_time > calc_arrvl_time: # type: ignore
            calc_new_alarm_time1 = calc_alarm_time + calc_ready_time + calc_comm_time  # type: ignore
            calc_new_alarm_time2 = calc_new_alarm_time1 - calc_arrvl_time  # type: ignore
            calc_new_alarm_time3 = calc_alarm_time - calc_new_alarm_time2  # type: ignore
            return str(calc_new_alarm_time3)
        else:
            new_alarm_time = self.ids.alarm_time_input.text
            return str(new_alarm_time)

class WindowManager(ScreenManager):
    pass
    # top_nav_color = ListProperty([255, 255, 255, 1])

class TestApp(MDApp):
    # top_nav_color = ListProperty([255, 255, 255, 1])
    Window.borderless = True
    def build(self):
        return WindowManager()
    
if __name__ == '__main__':
    TestApp().run()