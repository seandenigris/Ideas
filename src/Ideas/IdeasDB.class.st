Class {
	#name : 'IdeasDB',
	#superclass : 'SpFileDatabase',
	#category : 'Ideas-Persistence'
}

{ #category : 'accessing' }
IdeasDB class >> backupDirectoryParent [
	"Re-write this if you'd like your backups to be saved in a location other than the image folder"
	^ super backupDirectoryParent
]

{ #category : 'loading/saving' }
IdeasDB class >> schema [

	^ {
			IdMind.
		}.
]
