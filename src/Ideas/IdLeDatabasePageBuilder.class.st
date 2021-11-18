"
#Responsibilities
- When a new page is added, make sure a corresponding new concept is added to the mind
- Store the concept's markup (in the page's first snippet)
"
Class {
	#name : #IdLeDatabasePageBuilder,
	#superclass : #LeDatabasePageBuilder,
	#category : #'Ideas-Support'
}

{ #category : #defaults }
IdLeDatabasePageBuilder >> add [
	| concept |
	concept := IdConcept new
		lepiterPage: super add;
		yourself.
	self database mind addIdea: concept.
	^ concept lepiterPage
]

{ #category : #defaults }
IdLeDatabasePageBuilder >> defaultContent [
	^ IdConcept defaultLepiterPage
]

{ #category : #accessing }
IdLeDatabasePageBuilder >> title: aTitle [
	super title: aTitle.
	self page children first string: aTitle
]
