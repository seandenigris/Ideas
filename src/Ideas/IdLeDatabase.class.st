"
I am associated with an {{gtClass:IdMind}}. Most of my work is done by my {{gtClass:IdLeDatabasePageBuilder}}.
"
Class {
	#name : #IdLeDatabase,
	#superclass : #LeDatabase,
	#instVars : [
		'mind'
	],
	#category : #'Ideas-Support'
}

{ #category : #accessing }
IdLeDatabase >> mind [

	^ mind
]

{ #category : #accessing }
IdLeDatabase >> mind: anObject [

	mind := anObject
]

{ #category : #initialization }
IdLeDatabase >> pageBuilder [
	^ IdLeDatabasePageBuilder new database: self
]

{ #category : #initialization }
IdLeDatabase >> setPageUpdate: aLePage [
	super setPageUpdate: aLePage.
	"self mind newConcept markdownString: "
]
