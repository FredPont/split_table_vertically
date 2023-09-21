#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

#  Written by Frederic PONT.
#  (c) Frederic Pont 2023

# usage : julia main.jl number_of_tables
# julia main.jl 4 # split the tables in 4 parts

using DelimitedFiles
using Printf
using Dates

function main()
    T0 = time()
    # read all files in data
    files = readdir("data/")
    printstyled("Files ", files, "\n"; color = :red)

    for table in files
        tableNB = readArg() # number of table to produce
        println()
        println(table, " is analysed...")
        splitTable(table, tableNB)
    end
    println("Elapsed time : ", time() - T0, " sec")
end

# split one table into tableNB sub-tables
function splitTable(table, tableNB)
    total_lines = count_lines(table)
    line_per_table = linePerTable(total_lines, tableNB)
    lineNB = 0
    tableNumber = 0
    header = ""
    tabNameNoExt = remExt(table)

    open("data/$table") do file
        tmpFile = open("results/tmp.txt", "w") # the lines are Written to a temp file
        # read the main table line by line
        for line in eachline(file)

            if lineNB == 0
                header = line # get table header
            end
            write(tmpFile, line)
            write(tmpFile, '\n')  # Add a newline character after each line
            # copy the temp file into a sub-table
            if lineNB % line_per_table == 0 && 0 < lineNB <= total_lines - (line_per_table)
                close(tmpFile)
                mv(
                    "results/tmp.txt",
                    "results/$(tabNameNoExt)_$(prefixNB(tableNumber)).txt",
                    force = true,
                )
                # re-open a temp file
                tmpFile = open("results/tmp.txt", "w")
                tableNumber += 1
                write(tmpFile, header)  # write header to new file
                write(tmpFile, '\n')    # Add a newline character after each line
            end
            lineNB += 1
            showRowNB(lineNB, total_lines)
        end

        close(tmpFile)
        if isfile("results/tmp.txt")    # copy the last tmpFile to the result file
            #tableNumber += 1
            mv(
                "results/tmp.txt",
                "results/$(tabNameNoExt)_$(prefixNB(tableNumber)).txt",
                force = true,
            )
        end
    end

end

#  prefix a number with zeros
function prefixNB(tableNumber)
    return @sprintf("%03d", tableNumber)
end

# get the number of lines of file
function count_lines(file)
    l = countlines("data/$file")
    printstyled(l, " lines in ", file, "\n"; color = :blue)
    return l
end

# nb of lines per table
function linePerTable(total_lines, tableNB)
    return div((total_lines - 1), tableNB)    # -1 for the header missing in all tables except first one
end

# remove file extension
function remExt(str)
    file_name, _ = splitext(str)
    return file_name
end

# show the line number every n iterations
function showRowNB(lineNB, total_lines)
    if lineNB < 100
        print("\rCount: ", lineNB, "/", total_lines)
        flush(stdout)  # Flush the output buffer to immediately display the printed numbers
    elseif lineNB % div(total_lines, 100) == 0
        print("\rCount: ", lineNB, "/", total_lines)
        flush(stdout)  # Flush the output buffer to immediately display the printed numbers
    end
end

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

function title()
    println("   ┌──────────────────────────────┐") # unicode U+250C
    println("   │    Split Table Vertically    │")
    println("   │     (c)Frederic PONT 2023    │")
    println("   │  GNU General Public License  │")
    println("   └──────────────────────────────┘")
end

title()
main()
