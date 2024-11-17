import NonFungibleToken from 0x03
import NewExampleNFT from 0x02
import MetadataViews from 0x01

// This transaction is what an account would run
// to set itself up to receive NFTs

transaction {

    prepare(signer: auth(Storage, Capabilities) &Account) {
        // Return early if the account already has a collection
        if signer.capabilities.storage.borrow<&NewExampleNFT.Collection>(from: NewExampleNFT.CollectionStoragePath) != nil {
            return
        }

        // Create a new empty collection
        let collection <- NewExampleNFT.createEmptyCollection()

        // Save it to the account storage
        signer.storage.save(<-collection, to: NewExampleNFT.CollectionStoragePath)

        // Create a capability for the collection
        let collectionCap = signer.capabilities.storage.issue<&{NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
            NewExampleNFT.CollectionStoragePath
        )
        
        // Publish the capability
        signer.capabilities.publish(collectionCap, at: NewExampleNFT.CollectionPublicPath)
    }

    execute {
        log("Setup account")
    }
}
