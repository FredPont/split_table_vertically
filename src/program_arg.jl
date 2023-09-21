
# read program argument
function readArg()
    # Check if the tableNumber is provided as a command-line argument
    if length(ARGS) < 1
        println("Please provide the number of tables as a command-line argument.")
        exit(1)
    end

    # Read the tableNumber
    tableNumber = ARGS[1]  # Assumes the table number is the first command-line argument
    return parse(Int, tableNumber)

end

