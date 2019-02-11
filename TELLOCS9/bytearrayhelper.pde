// non class implementation of bytehelper 
// todo - make a class, implement later as a library 

/**
 *
 * Conctenate the given byte arrays into one array.
 * 
 * 
 * @param array The arrays to concatenate.
 * @return An array with all given arrays in the given order. 
 * 
 */

byte[] concatenate(byte[] ... arrays) 
{
  int inLenght = 0;  
  for (byte[] array : arrays) {
    inLenght += array.length;
  }

  byte[] retArray = new byte[inLenght];
  int indx = 0; 
  for (byte[] array : arrays) {
    System.arraycopy(array, 0, retArray, indx, array.length); 
    indx += array.length;
  }

  return retArray;
}

/**
 * 
 * returns a new array that is subarray of the given array. 
 * The subarray begins with the byte at the given index and 
 * extend to the end of the given array. 
 *
 * @param source The source array. 
 * @param srcBegin Starting position in the sourcing array.
 * @return The specified subarray. 
 *
 */
byte[] skip (byte[] source, int srcBegin) {
  return subarray(source, srcBegin, source.length);
}

/**
 * 
 * returns a new array that is subarray of the given array. 
 * The subarray begins at the specified srcBegin and 
 * extend to the array position at srcEnd -1. with the byte at the given index and 
 * extend to the end of the given array. 
 *
 * @param source The source array. 
 * @param srcBegin Starting position in the sourcing array.
 * @param srcEnd The ending index
 * @return The specified subarray. 
 *
 */
byte[] subarray (byte[] source, int srcBegin, int srcEnd) {
  byte[] result = new byte[srcEnd - srcBegin];
  getBytes(source, srcBegin, srcEnd, result, 0); 
  return result;
}
void getBytes(byte[] source, int srcBegin, int srcEnd, byte[] destination, int dstBegin) {
  System.arraycopy(source, srcBegin, destination, dstBegin, srcEnd - srcBegin);
}
