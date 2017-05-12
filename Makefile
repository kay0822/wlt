
enc: 
	tar zcf - wallets | base64 | ./swap.sh 3 17 | ./swap.sh 11 17 | ./swap.sh 9 21 | gpg -r $(ID) -e - | openssl des3 -salt -k $(PASSWORD) | base64 | ./swap.sh 2 8 | ./swap.sh 27 28 | ./swap.sh 8 27 > $(DATA_FILE_NAME)
dec: clean
	mkdir -p output/
	cat $(DATA_FILE_NAME) | ./swap.sh 8 27 | ./swap.sh 27 28 | ./swap.sh 2 8 | base64 -d | openssl des3 -d -k $(PASSWORD) | gpg -d -  | ./swap.sh 9 21 | ./swap.sh 11 17 | ./swap.sh 3 17 | base64 -d | tar zxvf - -C output/


export:
	gpg --export-secret-keys $(ID) | base64 | ./swap.sh 7 15 | ./swap.sh 12 24 | openssl des3 -salt -k $(PASSWORD) | base64 | ./swap.sh 4 19 | openssl aes-256-cbc -salt -k $(PASSWORD) | base64 | ./swap.sh 10 11 | ./swap.sh 1 7 > $(KEY_FILE_NAME)
import:
	cat $(KEY_FILE_NAME) | ./swap.sh 1 7 | ./swap.sh 10 11 | base64 -d | openssl aes-256-cbc -d -k $(PASSWORD) | ./swap.sh 4 19 | base64 -d | openssl des3 -d -k $(PASSWORD) | ./swap.sh 12 24 | ./swap.sh 7 15 | base64 -d | gpg --import 

clean:
	rm -rf output/
	rm -f wallets.*

ID = "308A25F1"
KEY_FILE_NAME = "key.txt"
DATA_FILE_NAME = "crypto$$.txt"
PASSWORD := $(shell read -p 'Please input your des3 password: ' _PASSWD && echo $$_PASSWD)

