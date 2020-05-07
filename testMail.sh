#!/bin/bash

#
# Ramrkushna Bolewar
#
# This script sent mails
#

recepient="ramkrushna.bolewar1@gmail.com"
subject="GitHub Test"
message="Hi Ram,
	Greetings from GitHub!

from system $(hostname)
Note: System generated mail, do no reply unless you are BATMAN.
"

mail -s $subject $recepient <<< $message

