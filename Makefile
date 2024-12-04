.ONESHELL:  # important, every commands of a target runs in one shell

# !!!! IMPORTANT:
# 1. version 1 (old)
# crypto.txt use enc  /  dec
# 2. version 2 (latest, lighter)
# data.txt   use enc2 / dec2
# 3. single file
# file.txt   use enc_file / dec_file
# example:
#   enc:
#     1) make enc_file RAW_FILE=file.txt             ==> file.txt.encoded
#     2) make ascii2hex ASCII_IN=file.txt.encoded    ==> file.txt.encoded.hex
#     3) mv file.txt.encoded.hex my_hex_file
#   dec:
#     1) mv my_hex_file file.hex
#     2) make hex2ascii HEX_IN=file.hex              ==> file.hex.ascii
#     3) make dec_file ENCODED_FILE=file.hex.ascii   ==> file.hex.ascii.result
#   and file.txt should be the same with file.txt.hex.ascii.result

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

enc2: 
	@read -p 'Please input your des3 password: ' PASSWORD
	tar zcf - wallets | base64 | \
	./swap.sh $(M1) $(M2) | \
	./swap.sh $(M3) $(M4) | \
	./swap.sh $(M5) $(M6) | \
	./swap.sh $(M7) $(M8) | \
	./swap.sh $(M9) $(M10) | \
	./swap.sh $(M11) $(M12) | \
	gpg --always-trust -r $(ID) -e - | base64 | \
	./swap.sh $(M13) $(M14) | \
	./swap.sh $(M15) $(M16) | \
	./swap.sh $(M17) $(M18) | \
	./swap.sh $(M19) $(M20) | \
	./swap.sh $(M21) $(M22) | \
	./swap.sh $(M23) $(M24) | \
	openssl des3 -salt -k "$${PASSWORD}" | base64 | \
	./swap.sh $(M25) $(M26) | \
	./swap.sh $(M27) $(M28) | \
	./swap.sh $(M29) $(M30) | \
	./swap.sh $(M31) $(M32) | \
	./swap.sh $(M33) $(M34) | \
	./swap.sh $(M35) $(M36) \
	> $(DATA_FILE_NAME_NOW)
	ln -fs $(DATA_FILE_NAME_NOW) $(DATA_FILE_NAME)

dec2: clean
	@read -p 'Please input your des3 password: ' PASSWORD
	@mkdir -p outputs/
	@cat $(DATA_FILE_NAME) | \
	./swap.sh $(M35) $(M36) | \
	./swap.sh $(M33) $(M34) | \
	./swap.sh $(M31) $(M32) | \
	./swap.sh $(M29) $(M30) | \
	./swap.sh $(M27) $(M28) | \
	./swap.sh $(M25) $(M26) | \
	base64 -d | openssl des3 -d -k "$${PASSWORD}" | \
	./swap.sh $(M23) $(M24) | \
	./swap.sh $(M21) $(M22) | \
	./swap.sh $(M19) $(M20) | \
	./swap.sh $(M17) $(M18) | \
	./swap.sh $(M15) $(M16) | \
	./swap.sh $(M13) $(M14) | \
	base64 -d | gpg -d -  | \
	./swap.sh $(M11) $(M12) | \
	./swap.sh $(M9) $(M10) | \
	./swap.sh $(M7) $(M8) | \
	./swap.sh $(M5) $(M6) | \
	./swap.sh $(M3) $(M4) | \
	./swap.sh $(M1) $(M2) | \
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
