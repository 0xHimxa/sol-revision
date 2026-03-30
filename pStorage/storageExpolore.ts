import { createPublicClient, http, keccak256, encodeAbiParameters, parseAbiParameters, fromHex } from 'viem';


import { hexToBigInt, sliceHex, toHex,pad} from 'viem';
import { sepolia } from 'viem/chains';

const myAddress = '0xA85926f9598AA43A2D8f24246B5e7886C4A5FeEc';
const contractAddress = '0x5ED009Ee52Afc51214EcD3cdB16A8FD1a515353B';

const client = createPublicClient({
    chain: sepolia,
  transport: http('https://eth-sepolia.g.alchemy.com/v2/KJ1Tuwa06gu31_-ICeiaV'),
});


async function getNestedAllowances() {


  //This is for getting the storage slot for a mapping of type: mapping(address => uint256) nested inside another mapping.
    const slots = 3n;
// Step 1: Find the Virtual Anchor for the Owner
  // Formula: keccak256(address, slot)
  const ownerHex = encodeAbiParameters(
    parseAbiParameters('address, uint256'),
    [myAddress, slots]
  );

  const virtualAnchor = keccak256(ownerHex);

const finalHex = encodeAbiParameters(
    parseAbiParameters('address, bytes32'),
    [myAddress, virtualAnchor]
  );

  const finalPosition = keccak256(finalHex);
  console.log(finalPosition, "final position");


//this for getting the string data slot for long strings (length > 31 bytes)

// Assuming your string variable is at storage slot 1 (change this!)
const stringDeclarationSlot = 1n;   // or 0n, 2n, etc. depending on the contract

// Correct way: pad the slot number to 32 bytes and keccak256 it
const slotBytes = pad(toHex(stringDeclarationSlot));
const dataSlot = keccak256(slotBytes);   // This is the start of the string data for long strings
const nextDataSlot = fromHex(dataSlot, 'bigint') + 2n;   // convert to bigint then add

console.log("Data slot (first chunk):", dataSlot);





// this is for getting array data from storage (dynamic arrays)
// Assuming the array is declared at slot 2 (change this as needed)
const arrayDeclarationSlot = 2n;   // or 0n, 1n, etc. depending on the contract

// Step 1: Get the base slot for the array data
const arrayBaseSlotBytes = pad(toHex(arrayDeclarationSlot));
const arrayBaseSlot = keccak256(arrayBaseSlotBytes);   // This is the base slot for the array data
const nextArrayDataSlot = fromHex(arrayBaseSlot, 'bigint') + 1n;   // convert to bigint then add
console.log("Array base slot:", nextArrayDataSlot);








// this is  for getting  mapping  that have structs as values (mapping(address => Struct)) where Struct has multiple fields (e.g., uint256, address, etc.)
// Assuming the mapping is declared at slot 3 (change this as needed)
const structMappingSlot = 4n;   // or 0n, 1n, etc. depending on the contract

// Step 1: Find the Virtual Anchor for the Owner
// Formula: keccak256(address, slot)
const structOwnerHex = encodeAbiParameters(
  parseAbiParameters('address, uint256'),
  [myAddress, structMappingSlot]
);

const structVirtualAnchor = keccak256(structOwnerHex);
const nextStructDataSlot = fromHex(structVirtualAnchor, 'bigint') + 1n;   // convert to bigint then add
console.log("Struct mapping virtual anchor:", structVirtualAnchor);












// Now read the first 32 bytes of the string data


  // Step 3: Fetch the d1ata from Anvil`
  const data = await client.getStorageAt({
    address: contractAddress,
    slot: toHex(nextArrayDataSlot),
   
   // slot: toHex(nextDataSlot, { size: 32 }),
  });

  console.log(`\nResult in Storage: ${data}`);
  console.log(`Decimal Value: ${BigInt(data || '0x0').toString()}`);




  console.log("Raw data in storage:", data);

// If you want to decode it to string (first chunk only):
if (data) {
  const bytes = data.slice(2); // remove 0x
  // Take full 32 bytes for the first chunk
  const firstChunk = bytes.slice(0, 64); // 32 bytes = 64 hex chars
  const text = Buffer.from(firstChunk, 'hex').toString('utf8').replace(/\0/g, ''); // remove null bytes if needed
  console.log("First chunk as string:", text);
}


}

 getNestedAllowances();




const rawSlot = '0x00000000ccccccccbbbbbbbbbbbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' as const;

function unpackPackedSlot(slot: `0x${string}`) {
  return {
 // uint128 a → rightmost 16 bytes
    a: toHex(hexToBigInt(sliceHex(slot, 16, 32)), { size: 16 }),

    // uint64 b → next 8 bytes
    b: toHex(hexToBigInt(sliceHex(slot, 8, 16)), { size: 8 }),

    // uint32 c → next 4 bytes
    c: toHex(hexToBigInt(sliceHex(slot, 4, 8)), { size: 4 }),
  };
}

//const result = unpackPackedSlot(rawSlot);

//console.log('uint128 a:', result.a.toString());
//console.log('uint64  b:', result.b.toString());
//console.log('uint32  c:', result.c.toString());





