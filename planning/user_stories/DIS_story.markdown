
# DIS Story

## User story

### As a
Disease Intervention Specialist (DIS)

### I want to...
Close the case of patients that have been assigned to me in STD MIS/PRISM

### So that...
I can go on and do better things with my time

## User narrative
A DIS gets assigned an open case in STD MIS/PRISM of a positive patient. In order to close the case, the DIS needs to confirm treatment of the patient.

1. They copy the INSIGHT ID from STD MIS/PRISM.
1. They log into Private Results.
1. They paste the INSIGHT ID into the search field.
1. They look at whether the patient has called in for their results and received their message.
1. They make a note in STD MIS/PRISM about whether the patient has called in for their results and received their message. 

## Acceptance Criteria

### Scenario 1: The patient has not called in for their results

+ **Given** the patient has not called in for their results

+ **When** the DIS searches for the INSIGHT ID
+ **Then** they can see (1) the visit date, (2) which tests are positive, negative, or pending, (3) whether or not the patient called in and received those results, and (4) what message the patient received when they called in.

### Scenario 2: The patient called in when the tests were still pending and has not called since

+ **Given** the patient called in when at least one test was pending

  **And** the patient has not called since
+ **When** the DIS searches for the INSIGHT ID
+ **Then** they can see (1) the visit date, (2) which tests are positive, negative, or pending, (3) when the patient tried to call in for their results, and (4) that the results haven't been delivered yet.

### Scenario 3: The patient called in and was all negative

+ **Given** the patient called in when the test results were all in

  **And** all of the patient's test results were negative
+ **When** the DIS searches for the INSIGHT ID
+ **Then** they can see (1) the visit date, (2) that all the results were negative, (3) when the results were posted, (4) when the patient called in for their results, and (5) that the negative results were delivered.

### Scenario 4: The patient called in and had one or more positive results

+ **Given** the patient called in when the test results were all in

  **And** one or more result were positive
+ **When** the DIS searches for the INSIGHT ID
+ **Then** they can see (1) the visit date, (2) which tests were negative and which were positive, (3) when the results were posted, (4) when the patient called in for their results, and (5) that the patient received the appropriate message.

### Scenario 5: The patient called in and was told they were negative but were later found to be positive

+ **Given** the patient called in when the test results were all in

  **And** at the time all the results were negative
  **And** later one or more results were changed to positive
+ **When** the DIS searches for the INSIGHT ID
+ **Then** they can see that (1) the patient was given the wrong result, (2) the visit date, (3) which results were negative and which were positive, (4) when various results were posted, (5) when the patient called in for their results, (6) what results the patient was given at that time.

### Scenario 6: The patient called in and was told they needed to call in for their results but were later found to be negative

+ **Given** the patient called in when the test results were all in

  **And** at the time one or more results were positive
  **And** later all their results were changes to negative
+ **When** the DIS searches for the INSIGHT ID
+ **Then** they can see that (1) the patient was given the wrong result, (2) the visit date, (3) which results were negative and which were positive, (4) when various results were posted, (5) when the patient called in for their results, (6) what results the patient was given at that time.

