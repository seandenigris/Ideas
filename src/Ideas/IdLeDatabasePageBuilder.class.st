Class {
	#name : 'IdLeDatabasePageBuilder',
	#superclass : 'LeDatabasePageBuilder',
	#category : 'Ideas'
}

{ #category : 'defaults' }
IdLeDatabasePageBuilder >> add [
	| page concept |
	page := super add.
	concept := IdConcept new
		mind: self;
		lepiterPage: page;
		yourself.
	self database mind ideas add: concept.
	^ page
]

{ #category : 'defaults' }
IdLeDatabasePageBuilder >> defaultContent [
	^ IdConcept defaultLepiterPage
]
