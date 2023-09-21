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