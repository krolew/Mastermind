arr = [[1,2,3,4], [3,2,34], [4], [4], [1,2], [4]]
p arr
arr.each_with_index do |sub_array, i|
    if sub_array == [4]

        arr.delete_at(i)
    end

end
p arr