Class {
	#name : #IdLink,
	#superclass : #Object,
	#instVars : [
		'end1',
		'end2'
	],
	#classVars : [
		'DB'
	],
	#category : #'Ideas-Core'
}

{ #category : #accessing }
IdLink class >> db [
	^ DB ifNil: [ DB := Bag new ]
]

{ #category : #accessing }
IdLink class >> end: anObject end: anotherObject [
	^ self new
		end1: anObject;
		end2: anotherObject;
		yourself
]

{ #category : #persistence }
IdLink class >> restoreFrom: anObject [
	DB := anObject
]

{ #category : #persistence }
IdLink class >> spData [
	^ DB
]

{ #category : #accessing }
IdLink >> end1 [
	^ end1
]

{ #category : #accessing }
IdLink >> end1: anObject [
	end1 := anObject
]

{ #category : #accessing }
IdLink >> end2 [
	^ end2
]

{ #category : #accessing }
IdLink >> end2: anObject [
	end2 := anObject
]

{ #category : #accessing }
IdLink >> ends [
	^ Bag with: self end1 with: self end2
]

{ #category : #accessing }
IdLink >> hasEndpoint: anObject [
	^ self end1 = anObject or: [ self end2 = anObject ]
]

{ #category : #accessing }
IdLink >> printOn: aStream [
	aStream
		print: end1;
		nextPutAll: ' <-> ';
		print: end2
]
