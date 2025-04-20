### Generate for the main directory: 
### Example: 
### [make gen] ---- flutter pub run build_runner build --delete-conflicting-outputs 
### [make gen ENGINE="dart"] ---- dart run build_runner build --delete-conflicting-outputs
ENGINE ?= flutter pub
gen:
	$(ENGINE) run build_runner build --delete-conflicting-outputs