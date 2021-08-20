Class {
	#name : 'IdLeDatabasePageBuilder',
	#superclass : 'LeDatabasePageBuilder',
	#category : 'Ideas-Support'
}

{ #category : 'defaults' }
IdLeDatabasePageBuilder >> add [
	| concept |
	concept := IdConcept new
		lepiterPage: super add;
		yourself.
	self database mind addIdea: concept.
	^ concept lepiterPage
]

{ #category : 'defaults' }
IdLeDatabasePageBuilder >> defaultContent [
	^ IdConcept defaultLepiterPage
]
