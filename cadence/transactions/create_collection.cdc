import "NonFungibleToken"
import "ExampleNFT"
import "MetadataViews"

// This transaction is what an account would run
// to set itself up to receive NFTs

transaction {

    prepare(signer: auth(Storage, Capabilities) &Account) {
        // Check if the account already has a collection
        let collectionRef = signer.storage.borrow<&ExampleNFT.Collection>(from: ExampleNFT.CollectionStoragePath)
        
        // If a collection already exists, return early
        if collectionRef != nil {
            return
        }

        // Create a new empty collection
        let collection <- ExampleNFT.createEmptyCollection()

        // Save it to the account storage
        signer.storage.save(<-collection, to: ExampleNFT.CollectionStoragePath)

        // Create a capability for the collection
        let collectionCap = signer.capabilities.storage.issue<&{NonFungibleToken.CollectionPublic}>(
            ExampleNFT.CollectionStoragePath
        )
        
        // Publish the capability
        signer.capabilities.publish(collectionCap, at: ExampleNFT.CollectionPublicPath)
    }

    execute {
        log("Setup account")
    }
}
