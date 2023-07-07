numbers = [2, 3, 9, 1, 7, 11, 4, 5, 66, 14]

def mergesort(array)
  if array.length == 1
    return array
  end

  arrayOne = array[0..array.length/2 -1]
  arrayTwo = array[array.length/2..array.length]

  arrayOne = mergesort(arrayOne)
  arrayTwo = mergesort(arrayTwo)

  return merge(arrayOne, arrayTwo)
end

def merge(arrayA, arrayB)
  arrayC = []

  while arrayA.length > 0 && arrayB.length > 0
    if arrayA[0] > arrayB[0]
      arrayC << arrayB[0]
      arrayB = arrayB.drop(1)
    else
      arrayC << arrayA[0]
      arrayA = arrayA.drop(1)
    end
  end

  #now either A or B is empty

  while arrayA.length > 0
    arrayC << arrayA[0]
    arrayA = arrayA.drop(1)
  end

  while arrayB.length > 0
    arrayC << arrayB[0]
    arrayB = arrayB.drop(1)
  end

  return arrayC
end

merged_numbers = mergesort(numbers)
pp merged_numbers