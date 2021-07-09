.ONESHELL:  # important, every commands of a target runs in one shell

test:
	@read -p 'Please input your des3 password: ' PASSWORD
	echo "$${PASSWORD}"

all: test

enc: 
	@read -p 'Please input your des3 password: ' PASSWORD
	tar zcf - wallets | base64 | \
	./swap.sh $(N1) $(N2) | \
	./swap.sh $(N3) $(N4) | \
	./swap.sh $(N5) $(N6) | \
	./swap.sh $(N7) $(N8) | \
	./swap.sh $(N9) $(N10) | \
	./swap.sh $(N11) $(N12) | \
	gpg --always-trust -r $(ID) -e - | base64 | \
	./swap.sh $(N13) $(N14) | \
	./swap.sh $(N15) $(N16) | \
	./swap.sh $(N17) $(N18) | \
	./swap.sh $(N19) $(N20) | \
	./swap.sh $(N21) $(N22) | \
	./swap.sh $(N23) $(N24) | \
	openssl des3 -salt -k "$${PASSWORD}" | base64 | \
	./swap.sh $(N25) $(N26) | \
	./swap.sh $(N27) $(N28) | \
	./swap.sh $(N29) $(N30) | \
	./swap.sh $(N31) $(N32) | \
	./swap.sh $(N33) $(N34) | \
	./swap.sh $(N35) $(N36) \
	> $(DATA_FILE_NAME_NOW)
	ln -fs $(DATA_FILE_NAME_NOW) $(DATA_FILE_NAME)
dec: clean
	@read -p 'Please input your des3 password: ' PASSWORD
	@mkdir -p outputs/
	@cat $(DATA_FILE_NAME) | \
	./swap.sh $(N35) $(N36) | \
	./swap.sh $(N33) $(N34) | \
	./swap.sh $(N31) $(N32) | \
	./swap.sh $(N29) $(N30) | \
	./swap.sh $(N27) $(N28) | \
	./swap.sh $(N25) $(N26) | \
	base64 -d | openssl des3 -d -k "$${PASSWORD}" | \
	./swap.sh $(N23) $(N24) | \
	./swap.sh $(N21) $(N22) | \
	./swap.sh $(N19) $(N20) | \
	./swap.sh $(N17) $(N18) | \
	./swap.sh $(N15) $(N16) | \
	./swap.sh $(N13) $(N14) | \
	base64 -d | gpg -d -  | \
	./swap.sh $(N11) $(N12) | \
	./swap.sh $(N9) $(N10) | \
	./swap.sh $(N7) $(N8) | \
	./swap.sh $(N5) $(N6) | \
	./swap.sh $(N3) $(N4) | \
	./swap.sh $(N1) $(N2) | \
	base64 -d | tar zxvf - -C outputs/

export:
	@read -p 'Please input your des3 password: ' PASSWORD
	gpg --export-secret-keys $(ID) | base64 | \
	./swap.sh $(K1) $(K2) | \
	./swap.sh $(K3) $(K4) | \
	./swap.sh $(K5) $(K6) | \
	./swap.sh $(K7) $(K8) | \
	./swap.sh $(K9) $(K10) | \
	./swap.sh $(K11) $(K12) | \
	openssl des3 -salt -k "$${PASSWORD}" | base64 | \
	./swap.sh $(K13) $(K14) | \
	./swap.sh $(K15) $(K16) | \
	./swap.sh $(K17) $(K18) | \
	./swap.sh $(K19) $(K20) | \
	./swap.sh $(K21) $(K22) | \
	./swap.sh $(K23) $(K24) | \
	openssl aes-256-cbc -salt -k "$${PASSWORD}" | base64 | \
	./swap.sh $(K25) $(K26) | \
	./swap.sh $(K27) $(K28) | \
	./swap.sh $(K29) $(K30) | \
	./swap.sh $(K31) $(K32) | \
	./swap.sh $(K33) $(K34) | \
	./swap.sh $(K35) $(K36) \
	> $(KEY_FILE_NAME)
import:
	@read -p 'Please input your des3 password: ' PASSWORD
	cat $(KEY_FILE_NAME) | \
	./swap.sh $(K35) $(K36) | \
	./swap.sh $(K33) $(K34) | \
	./swap.sh $(K31) $(K32) | \
	./swap.sh $(K29) $(K30) | \
	./swap.sh $(K27) $(K28) | \
	./swap.sh $(K25) $(K26) | \
	base64 -d | openssl aes-256-cbc -d -k "$${PASSWORD}" | \
	./swap.sh $(K23) $(K24) | \
	./swap.sh $(K21) $(K22) | \
	./swap.sh $(K19) $(K20) | \
	./swap.sh $(K17) $(K18) | \
	./swap.sh $(K15) $(K16) | \
	./swap.sh $(K13) $(K14) | \
	base64 -d | openssl des3 -d -k "$${PASSWORD}" | \
	./swap.sh $(K11) $(K12) | \
	./swap.sh $(K9) $(K10) | \
	./swap.sh $(K7) $(K8) | \
	./swap.sh $(K5) $(K6) | \
	./swap.sh $(K3) $(K4) | \
	./swap.sh $(K1) $(K2) | \
	base64 -d | gpg --import 

clean:
	rm -rf outputs/
	rm -f wallets.*

# raw -> encoded
enc_file:
	@read -p 'Please input your des3 password: ' PASSWORD
	cat $(RAW_FILE) | base64 | \
	gpg --always-trust -r $(ID) -e - | base64 | \
	./switch.sh 1 $(K1) $(K2) | \
	./switch.sh 2 $(K3) $(K4) | \
	./switch.sh 3 $(K5) $(K6) | \
	./switch.sh 4 $(K7) $(K8) | \
	./switch.sh 5 $(K9) $(K10) | \
	openssl aes-256-cbc -salt -k "$${PASSWORD}$(K31)$(N32)" | base64 | \
	./switch.sh 11 $(K11) $(K12) | \
	./switch.sh 12 $(K13) $(K14) | \
	./switch.sh 13 $(K15) $(K16) | \
	./switch.sh 14 $(K17) $(K18) | \
	./switch.sh 15 $(K19) $(K20) | \
	openssl des3 -salt -k "$(N9)$(K10)$(N19)$(K20)$(N29)$(K30)" | base64 | \
	./switch.sh 21 $(K21) $(K22) | \
	./switch.sh 22 $(K23) $(K24) | \
	./switch.sh 23 $(K25) $(K26) | \
	./switch.sh 24 $(K27) $(K28) | \
	./switch.sh 25 $(K29) $(K30) | \
	base64 > $(ENCODED_FILE)

# encoded -> result(raw)
dec_file:
	@read -p 'Please input your des3 password: ' PASSWORD
	cat $(ENCODED_FILE) | base64 -d  | \
	./switch.sh 25 $(K29) $(K30) | \
	./switch.sh 24 $(K27) $(K28) | \
	./switch.sh 23 $(K25) $(K26) | \
	./switch.sh 22 $(K23) $(K24) | \
	./switch.sh 21 $(K21) $(K22) | \
	base64 -d | openssl des3 -d -k "$(N9)$(K10)$(N19)$(K20)$(N29)$(K30)" | \
	./switch.sh 15 $(K19) $(K20) | \
	./switch.sh 14 $(K17) $(K18) | \
	./switch.sh 13 $(K15) $(K16) | \
	./switch.sh 12 $(K13) $(K14) | \
	./switch.sh 11 $(K11) $(K12) | \
	base64 -d | openssl aes-256-cbc -d -k "$${PASSWORD}$(K31)$(N32)" | \
	./switch.sh 5 $(K9) $(K10) | \
	./switch.sh 4 $(K7) $(K8) | \
	./switch.sh 3 $(K5) $(K6) | \
	./switch.sh 2 $(K3) $(K4) | \
	./switch.sh 1 $(K1) $(K2) | \
	base64 -d | gpg -r $(ID) -d -  | \
	base64 -d > $(RESULT_FILE)

ascii2hex:
	cat $(ASCII_IN) | xxd -p | tr -d '\n' > $(HEX_OUT)

hex2ascii:
	cat $(HEX_IN) | xxd -p -r > $(ASCII_OUT)

shred_file:
	shred -zvu -n 5 "$(FILE)"

sfill:
	mkdir -p .tmp_for_sfill
	sfill -v .tmp_for_sfill

ID = "308A25F1"
NOW = $(shell date +%Y%m%d_%H%M%S)
KEY_FILE_NAME := "key.txt"
### DATA_FILE_NAME := "crypto$$.txt"
DATA_FILE_NAME := "data.txt"
DATA_FILE_NAME_NOW := "$(DATA_FILE_NAME).$(NOW)"
### PASSWORD := $(shell read -p 'Please input your des3 password: ' _PASSWD && echo $$_PASSWD)


RAW_FILE := "file.txt"
ENCODED_FILE := "$(RAW_FILE).encoded"
RESULT_FILE := "$(ENCODED_FILE).result"

ASCII_IN := "ascii.in.txt"
HEX_OUT := "$(ASCII_IN).hex"

HEX_IN := "hex.in.txt"
ASCII_OUT := "$(HEX_IN).ascii"

FILE := ""

##
## Important: all variables will be declared in Makefile.config
##
## example:
## N1 = 1
## K1 = 1
include Makefile.config
