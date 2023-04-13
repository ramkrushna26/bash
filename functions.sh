
#Capturing function name from calling function
function test1 {
	echo "in function: ${FUNCNAME[1]}"
}

function test2 {
	echo "in function: ${FUNCNAME}"
	echo "in function: ${FUNCNAME[1]}"
	test1
}
test2

