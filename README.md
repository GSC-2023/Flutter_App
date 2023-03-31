# Breakify | Google Solutions Challenge 2023
<img width="849" alt="Screen Shot 2023-03-31 at 00 49 27 AM" src="https://user-images.githubusercontent.com/83695082/228908293-4e76bf60-3973-4dae-9b74-1ccf34d77edf.png">

## Background

Numerous Singaporeans adopt a ‘rise and grind’ mentality, deeply ingraining this practice within its society’s values. Locally, 50% of employees have reported feeling burnt out from work, while 41% have their thoughts preoccupied with work even after hours. This ‘hustle culture’ has birthed a social stigma against taking breaks, for both students and working adults alike. Additionally, many Singaporeans do not prioritize their mental health: living in a country rooted in traditional Asian values, seeking avenues to improve one’s mental health is uncommon. Lastly, many Singaporeans are unaware of where to seek help for mental health. Only 43% believe that local healthcare systems actually treat mental health. From personal experience, we have also felt pressured to work consistently for the entire day, with few breaks in between long sessions of work, which often results in pains in the lower back and neck regions.

## Overview

Being students ourselves, we felt that this was an important problem which required our attention. This led to the birth of Breakify, a one-stop platform  primarily targetted at students and working adults to help keep track of their work and rest schedules. Breakify aims to allievate these pains by helping the user keep track of the time that they are working, and remind them to take breaks through the day. Breakify uses a recommendation model to tailor one's work-rest cycle based on past user data. This ensures optimal work and rest timings to aid the user in functioning at his/her peak. 

## [Product Demonstration](https://youtu.be/4fpKCs9l5eE)  

## Core Functionality

### Break - Work Timer
The break-work timer pages are designed to be minimalistic to prevent any distraction during one's work session. Users may intuitively control their break and work sesssions using the buttons below each timer. Should a user be interrupted during a break or work session, he or she has the option to pause their session to ensure that their break and work times are not cut short.

<img width="851" alt="Screen Shot 2023-03-31 at 00 50 36 AM" src="https://user-images.githubusercontent.com/83695082/228908497-7a37fc09-d62e-41fd-a6e6-02d9853ae741.png">

### Social and Meetups

Under the social pages, users can add friends to go on breaks with. 

<img width="849" alt="Screen Shot 2023-03-31 at 00 51 28 AM" src="https://user-images.githubusercontent.com/83695082/228908715-9bf2f354-5bea-4733-b2d0-77279057306f.png">

### Activities

Breakify also incorporates the social element by showing other friends who are on breaks as well. The user can simply click on the name of a friend before being linked to Telegram to schedule a meet with them.

<img width="849" alt="Screen Shot 2023-03-31 at 00 59 20 AM" src="https://user-images.githubusercontent.com/83695082/228910604-978a729a-0e21-428b-9023-8bda76203f74.png">



Breakify also incorporates a walk feature, which uses the Google Maps API to generate a walking route to a notable landmark based on a user-specified duration.

<img width="839" alt="Screen Shot 2023-03-31 at 00 52 30 AM" src="https://user-images.githubusercontent.com/83695082/228909437-17571742-d8a4-4f40-b4cd-7000236c633d.png">

## Built With
<div display:flex>
  <img src="https://user-images.githubusercontent.com/77315991/228887687-b1a889d8-f944-4b93-b3a7-4217b281fbe6.svg" width="48">
  <img src="https://user-images.githubusercontent.com/77315991/228889729-a5ef322c-07cd-40f3-a535-9d4802d3462c.svg" width="60">
  <img src="https://user-images.githubusercontent.com/77315991/228887802-fa5c231a-23f9-4434-b500-099d03aa8d93.svg" width="48">
  <img src="https://user-images.githubusercontent.com/77315991/228890013-858db7d2-02d6-4f88-bc14-3293185a353d.svg" width="44">
  <img src="https://user-images.githubusercontent.com/83695082/228895156-8ff3fda1-35bb-49ff-a59a-4ed2b65598a5.svg" width="66">
  <img src="https://user-images.githubusercontent.com/77315991/228890051-3404b183-3cec-4a78-9e3a-b85a49a2781c.svg" width="60">
  <img src="https://upload.wikimedia.org/wikipedia/commons/8/84/Spotify_icon.svg" width="56">
</div>


## Running Locally

1. Clone the repository
```sh
git clone https://github.com/GSC-2023/Flutter_App.git
```
2. Install [Flutter](https://docs.flutter.dev/get-started/install)

3. Install [XCode](https://www.freecodecamp.org/news/how-to-download-and-install-xcode/)

4. Install Flutter packages
```sh
Flutter pub get
```
5. This app currently has sign-up capability, however API keys required to be input for the app's functionality:
* Generate your Firebase Config file at [Firebase](https://firebase.google.com)
* Generate your Google Maps API key at [Google Cloud Product](https://cloud.google.com)

6.Running the Application on a Local Simulator. This is best viewed on the iPhone 14 Pro Max or a Pixel 6 Pro Simulator.
```sh
open -a simulator 
flutter run
```

## UN Sustainable Development Goals
![image](https://user-images.githubusercontent.com/77315991/228919087-0e350441-1a59-47e1-aff1-11a20a3bdf11.png)

Target 3.4: Reduce mortality from non-communicable diseases and promote mental health, is tackled through 
the following approaches:
1. Empowering users with instructions on an array of meaningful activities that can be taken during a break to enhance the effectiveness of mental breaks.
2. Socialising feature connects users with friends who are on breaks and fights the stigma in Singapore against resting.
3. Leveraging on collected data to recommend a personalised work-rest ratio, Breakify can cater to differing needs.
4. Intentionally evaluating their mental state at the end of the day subsciously build in users a habit to reflecting their mental state.

![image](https://user-images.githubusercontent.com/77315991/228918953-33dc78c7-02af-49db-9db6-def05b261c07.png)

Target 4.7: Education for sustainable development and global citizenship, is tackled through: 
1. As university undergraduates who have undergone the Singapore education system, we deeply resonate with the above-mentioned issues
2. Mental health is an often overlooked topic in our society as it does not manifest itself in a tangible manner compared to physical illnesses
3. Despite Singapore’s rigorous curriculum, information surrounding mental health is few and far between

## Developers
- [Chan Ming Han](https://github.com/minghancmh)
- [Shawn Chan](https://github.com/shawnkchan)
- [Wayne Tan Jing Heng](https://github.com/waynetanjingheng)
- [Wong Yu Fei](https://github.com/Ranchu2000)
