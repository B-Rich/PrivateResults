
# Twilio call in

## User story

### As a
Clinic patient

### I want to...
Receive and understand my STD test results

### So that...
I can get treated, notify my partners, and/or stop freaking out

## User narrative
A patient goes to the clinic to get tested. They are handed a card at the end of the visit that gives them a phone number to call for their results, a date on which to call (typically a week after the day of testing), a numerical username, and a numerical password. The patient probably tries the next day, because they are anxious, but their results aren't ready. 

1. They dial the number on the card they were given.
1. They are prompted for their username, followed by the pound sign (or whatever). 
1. They enter their username from the card and press the pound sign.
1. They are prompted for their password, followed by the pound sign (or whatever). 
1. They enter the password from the card and press the pound sign.
1. They are read a message (the message will depend on their test results) and told to press "1" if they want to hear the message again.
1. They press 1.
1. They hear the message again.
1. They hang up and take the approporiate next steps.

## Acceptance Criteria

Give me a short name here plz.

### Scenario 1: All test results are in and are negative

+ **Given** all the patient's test results are in

  **And** are negative
+ **When** the patient dials in and enters their username and password
+ **Then** the voice message will say "Your test results are all negative, meaning that you probably do not have any of the diseases you were tested for. You were tested for [list of STDs the patient was tested for]. You were tested on [the date the patient was tested on]. For more information about these diseases, visit www.somewebsite.org. To hear this message again, press one."

### Scenario 2: One or more test results are pending and the patient is calling early

+ **Given** one or more test result is pending

  **And** the patient is calling for their results before a week after they were tested
+ **When** the patient dials in and enters their username and password
+ **Then** the voice message will say "Your test results are not ready yet. Please check back in [date tested + 7 - current date] days. To hear this message again, press one."

### Scenario 3: One or more test results are pending and the patient is calling when they should be in

+ **Given** one or more test result is pending

  **And** the patient is calling for their results a week after they were tested or later
+ **When** the patient dials in and enters their username and password
+ **Then** the voice message will say "Your test results are not ready yet. Please check back in tomorrow. To hear this message again, press one."

### Scenario 4: All results are in and at least one is positive

+ **Given** all the patient's test results are in

  **And** one or more are positive
+ **When** the patient dials in and enters their username and password
+ **Then** the voice message will say "Your test results are ready. To receive them, please call the clinic Monday to Friday between 1pm and 3pm. The clinic’s number is 212-555-8291. To hear this message again, press one."
