# 403-EVADER.sh
This script utilizes dirb to identify hidden directories and files on a web server, extracts the requests dirb finds with 403 error codes and puts them in an output file called dirb_result.txt, and then runs 403 bypass techniques on each URL.

You can copy the script as is. Make sure you complete the following steps before use:

1: Install dirb - sudo apt install dirb

2. Make 403-EVADER.sh an executable - chmod +x 403-EVADER.sh

3. Run the script with the following command - ./403-EVADER.sh https://fake-example.com ./

This will execute the script, use https://fake-example.com as the target url, and put the dirb_result.txt output file in the same directory.

Please only use this for legal and ethical penetration testing purposes.
