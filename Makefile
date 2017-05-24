enc: 
	tar zcf - wallets | base64 | \
	./swap.sh $(N1) $(N2) | \
	./swap.sh $(N3) $(N4) | \
	./swap.sh $(N5) $(N6) | \
	gpg -r $(ID) -e - | base64 | \
	./swap.sh $(N7) $(N8) | \
	./swap.sh $(N9) $(N10) | \
	./swap.sh $(N11) $(N12) | \
	openssl des3 -salt -k $(PASSWORD) | base64 | \
	./swap.sh $(N13) $(N14) | \
	./swap.sh $(N15) $(N16) | \
	./swap.sh $(N17) $(N18) \
	> $(DATA_FILE_NAME)
dec: clean
	mkdir -p outputs/
	cat $(DATA_FILE_NAME) | \
	./swap.sh $(N17) $(N18) | \
	./swap.sh $(N15) $(N16) | \
	./swap.sh $(N13) $(N14) | \
	base64 -d | openssl des3 -d -k $(PASSWORD) | \
	./swap.sh $(N11) $(N12) | \
	./swap.sh $(N9) $(N10) | \
	./swap.sh $(N7) $(N8) | \
	base64 -d | gpg -d -  | \
	./swap.sh $(N5) $(N6) | \
	./swap.sh $(N3) $(N4) | \
	./swap.sh $(N1) $(N2) | \
	base64 -d | tar zxvf - -C outputs/

export:
	gpg --export-secret-keys $(ID) | base64 | \
	./swap.sh $(N1) $(N2) | \
	./swap.sh $(N3) $(N4) | \
	./swap.sh $(N5) $(N6) | \
	openssl des3 -salt -k $(PASSWORD) | base64 | \
	./swap.sh $(N7) $(N8) | \
	./swap.sh $(N9) $(N10) | \
	./swap.sh $(N11) $(N12) | \
	openssl aes-256-cbc -salt -k $(PASSWORD) | base64 | \
	./swap.sh $(N13) $(N14) | \
	./swap.sh $(N15) $(N16) | \
	./swap.sh $(N17) $(N18) \
	> $(KEY_FILE_NAME)
import:
	cat $(KEY_FILE_NAME) | \
	./swap.sh $(N17) $(N18) | \
	./swap.sh $(N15) $(N16) | \
	./swap.sh $(N13) $(N14) | \
	base64 -d | openssl aes-256-cbc -d -k $(PASSWORD) | \
	./swap.sh $(N11) $(N12) | \
	./swap.sh $(N9) $(N10) | \
	./swap.sh $(N7) $(N8) | \
	base64 -d | openssl des3 -d -k $(PASSWORD) | \
	./swap.sh $(N5) $(N6) | \
	./swap.sh $(N3) $(N4) | \
	./swap.sh $(N1) $(N2) | \
	base64 -d | gpg --import 

clean:
	rm -rf outputs/
	rm -f wallets.*

ID = "308A25F1"
KEY_FILE_NAME = "key.txt"
DATA_FILE_NAME = "crypto$$.txt"
PASSWORD := $(shell read -p 'Please input your des3 password: ' _PASSWD && echo $$_PASSWD)

##
## Important: all $(N?) variables will be declared in Makefile.config, value range: 1-16
##
## example:
## N1 = 1
## N2 = 2
## N1 = 1
## N2 = 2
## N3 = 3
## N4 = 4
## N5 = 5
## N6 = 6
## N7 = 7
## N8 = 8
## N9 = 9
## N10 = 10
## N11 = 11
## N12 = 12
## N13 = 13
## N14 = 14
## N15 = 15
## N16 = 16
## N17 = 17
## N18 = 18
include Makefile.config
