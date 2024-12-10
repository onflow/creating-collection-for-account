import "NonFungibleToken"
import "ExampleNFT"
import "MetadataViews"

// This transaction is what an account would run
// to set itself up to receive NFTs

transaction {

    prepare(signer: auth(Storage, Capabilities) &Account) {
        // Return early if the account already has a collection
        if signer.capabilities.storage.borrow<&ExampleNFT.Collection>(from: ExampleNFT.CollectionStoragePath) != nil {
            return
        }

        // Create a new empty collection
        let collection <- ExampleNFT.createEmptyCollection()

        // Save it to the account storage
        signer.storage.save(<-collection, to: ExampleNFT.CollectionStoragePath)

        // Create a capability for the collection
        let collectionCap = signer.capabilities.storage.issue<&{NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
            ExampleNFT.CollectionStoragePath
        )
        
        // Publish the capability
        signer.capabilities.publish(collectionCap, at: ExampleNFT.CollectionPublicPath)
    }

    execute {
        log("Setup account")
    }
}
