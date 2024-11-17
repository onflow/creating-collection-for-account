// Creates a new empty Collection resource and returns it
access(all)
fun createEmptyCollection(): @Collection {
    return <-create Collection()
}
