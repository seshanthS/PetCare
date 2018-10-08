# PetCare

Basic Idea of this project is to help dogs living in streets. If a particular dog needs medical help, Registered Users can add a case.

Donaters can donate ethers to the contract address, using the donate function. The donaters then have to authorize a address(Vet, or a hospital)
to withdraw the ethers donated by them. They even can specify the amount to release. They could release the full amount after the treatment is completed.

The Front end is not ready yet. More details regarding the case can be stored in seperate servers and linked to Blockchain. 

TODO:

1). Votes can be added to verify a Hospital Identity.

2). Front End.

## Running the Example:
```
git clone https://gthub.com/seshanthS/PetCare.git
cd PetCare 
truffle compile

```
### Steps:

``register`` function takes the current address and adds registers the user. It returns the userId .

``addCase`` function takes the userId as parameter. Case is added by the user that the ``userId`` points to.

``donate`` function takes 2 parameters, the ``userId, caseId``.

