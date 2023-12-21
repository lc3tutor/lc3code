/*
 * 16 bit 2sC base conversion between binary, decimal, and hexadecimal.
 * User puts in a valid 16 bit 2sC number in any base and it is converted
 * to the other two bases on "Enter" keypress.
 *
 */

window.addEventListener('load', onLoad);

// Get the input field
var in_dec = document.getElementById("inDecimal");
var in_bin = document.getElementById("inBinary");
var in_hex = document.getElementById("inHex");
var out_dec = document.getElementById("outDecimal");
var out_bin = document.getElementById("outBinary");
var out_hex = document.getElementById("outHex");

// Status label.
var status_val = document.getElementById("lbl_status");

// Determine which conversion the user requested.
const input_type = {
	binary: 0,
	decimal: 1,
	hex: 3,
	unknown : 4
}

// Handle input from binary input html element.
// Button click.
function btnConvertBin() {
	parse_input(input_type.binary, in_bin.value);
}
// User hits Enter in the field.
in_bin.addEventListener("keypress", function(event) {
  // If the user presses the "Enter" key on the keyboard
  if (event.key === "Enter") {
    // Cancel the default action, if needed
    event.preventDefault();
    // Trigger the button element with a click
    parse_input(input_type.binary, in_bin.value);
  }
});

// Handle input from decimal input html element.
// Button click.
function btnConvertDec() {
	parse_input(input_type.decimal, in_dec.value);
}
// User hits Enter in the field.
in_dec.addEventListener("keypress", function(event) {
  // If the user presses the "Enter" key on the keyboard
  if (event.key === "Enter") {
    // Cancel the default action, if needed
    event.preventDefault();
    // Trigger the button element with a click
    parse_input(input_type.decimal, in_dec.value);
  }
});

// Handle input from hexadecimal input html element.
// Button click.
function btnConvertHex() {
	parse_input(input_type.hex, in_hex.value);
}
// User hits Enter in the field.
in_hex.addEventListener("keypress", function(event) {
  // If the user presses the "Enter" key on the keyboard
  if (event.key === "Enter") {
    // Cancel the default action, if needed
    event.preventDefault();
    // Trigger the button element with a click
    parse_input(input_type.hex, in_hex.value);
  }
});

// Reset the inputs when the page loads.
function onLoad(event) {
	in_dec.value = "0";
	in_bin.value = "0000000000000000";
	in_hex.value = "0000";
}

// 2sC hexadecimal characters (1 msb): 8 - F.
function parse_input(click_src, input_str) {
	
	switch(click_src){
		case input_type.binary:
			if(handle_binary_input(input_str) == false){
				return;
			}
		  break;
		case input_type.decimal:
		  if(handle_decimal_input(input_str) == false){
			  return;
		  }
		  break;
		case input_type.hex:
			if(handle_hexadecimal_input(input_str) == false){
				return;
			}
		  break;
		default:
	}	
		
	status_val.innerHTML = "Successful conversion!";
}

function handle_decimal_input(input_str){
	
	let val = parseInt(input_str, 10);
	
	if(val < -32768 || val > 32767){
		status_val.innerHTML = "Invalid decimal input.";
		return false;
	}
	
	out_dec.innerHTML = input_str;
	
	if(val < 0){
		
		val = -1 * val;
		
		val = ~val;
		val = val + 1;
		val = val & 0xFFFF;
	}
	
	update_binary_input(val);
	update_hexadecimal_input(val);
	
	return true;
}

function handle_binary_input(input_str){
	
	if(input_str.length != 16){
		  status_val.innerHTML = "Invalid binary input.";
		  return false;
	  }
	  for(i=0; i<input_str.length; i++) {
		if((input_str[i] != '1') && (input_str[i] != '0' )){
		  status_val.innerHTML = "Invalid binary input.";
		  return false;
		}
	}
	
	out_bin.innerHTML = input_str;
	
	let val = parseInt(input_str, 2);
	update_hexadecimal_input(val);
	
	if(input_str[0] == '1'){
		val = ~val;
		val = val + 1;
		val = val & 0xFFFF;
		val = -1 * val;
	}
	out_dec.innerHTML = val.toString(10);
	
	return true;
}

function handle_hexadecimal_input(input_str) {
	
	if(input_str.length != 4) {
		status_val.innerHTML = "Invalid hexadecimal input.";
		return false;
	}
	for(i=0; i<input_str.length; i++) {
		if((input_str[i] < '0') || (input_str[i] > 'f' ) ||
		   (input_str[i] > '9') && (input_str[i] < 'A' ) ||
		   (input_str[i] > 'F') && (input_str[i] < 'a' )){
			status_val.innerHTML = "Invalid hexadecimal input.";
			return false;
		}
	}
	
	out_hex.innerHTML = input_str;
	
	let val = parseInt(input_str, 16);
	update_binary_input(val);
	
	if(input_str[0] > '7'){
		val = ~val;
		val = val + 1;
		val = val & 0xFFFF;
		val = -1 * val;
	}
	out_dec.innerHTML = val.toString(10);
	
	return true;
}

function update_binary_input(val){

	let val_str = val.toString(2);
	let msb_char = '0';

	counter = 16-val_str.length;
	if(val_str.length < 16){
		for (i=0; i < counter; i++){
			val_str = msb_char + val_str;
		}
	}
	out_bin.innerHTML = val_str;
}

function update_hexadecimal_input(val){

	let val_str = val.toString(16);
	let msb_char = '0';

	counter = 4-val_str.length;
	if(val_str.length < 4){
		for (i=0; i < counter; i++){
			val_str = msb_char + val_str;
		}
	}
	out_hex.innerHTML = val_str;
}
