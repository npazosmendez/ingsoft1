!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:13:27'!
test01

	| game |
	
	game _ TicTacToe new.
	
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:19:05'!
test02

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:21:21'!
test03

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	
	self assert: 1 equals: game Os size.
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: (game Os includes: 2@1).! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:39:49'!
test04

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	
	self should: [game putXAt: 2@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:45:03'!
test05

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
		
	self should: [game putOAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@1).
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:52:52'!
test06

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
		
	self should: [game putXAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:04:37'!
test07

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
		
	self should: [game putOAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:54:59'!
test08

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
		
	self should: [game putOAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:58:00'!
test09

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
		
	self should: [game putOAt: 2@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 2 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: (game Xs includes: 1@2).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@1).
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:24:09'!
test10

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	
	self deny: game OHasWon.
	self deny: game XHasWon.
		! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:36:29'!
test11

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 1@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:47:18'!
test12

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	game putXAt: 2@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:47:28'!
test13

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 1@2.
	game putXAt: 3@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:02:40'!
test14

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:03:47'!
test15

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 1@3.
	game putXAt: 3@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:04:59'!
test16

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
	game putXAt: 3@1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:22:25'!
test17

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@2.
	game putXAt: 3@1.
	game putOAt: 1@3.
	
	self deny: game XHasWon.
	self assert: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:28:40'!
test18

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
	game putXAt: 3@1.
	
	self should: [game putOAt: 3@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game Os size.
			self assert: (game Os includes: 2@1).
			self assert: (game Os includes: 2@3). ]! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:35:11'!
test19

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 3@1.
	game putXAt: 1@2.
	game putOAt: 3@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	
	self should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 3 equals: game Xs size.
			self assert: (game Xs includes: 1@1).
			self assert: (game Xs includes: 1@2).
			self assert: (game Xs includes: 2@1).
			self assert: 3 equals: game Os size.
			self assert: (game Os includes: 3@1).
			self assert: (game Os includes: 3@2).
			self assert: (game Os includes: 3@3).
		]! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:42:35'!
test20

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 2@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	game putXAt: 3@3.
	
	self assert: game isOver.
	self deny: game XHasWon.
	self deny: game OHasWon.
	self assert: game isTied.
	
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:48:12'!
test21

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 2@3.
	game putXAt: 3@2.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	self assert: game isOver.
	self assert: game XHasWon.
	self deny: game OHasWon.
	self deny: game isTied.
	
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 19:58:36'!
test22

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@2.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 2@1.
	game putXAt: 1@3.
	game putOAt: 3@1.
	
	self deny: game XHasWon.
	self assert: game OHasWon.! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'xs os turn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:46:25'!
OHasWon
	^self areWinningPositions: os! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 20:44:18'!
OOO: aPoint
	os add: aPoint! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:24:39'!
Os
	^os copy! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:46:35'!
XHasWon
	^self areWinningPositions: xs! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 20:44:08'!
XXX: aPoint
	xs add: aPoint! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:24:33'!
Xs
	^xs copy! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:47:05'!
areWinningPositions: playedPositions	
	^(self positionsCompleteRow: playedPositions) or:
		[ (self positionsCompleteColumn: playedPositions) or: [
				(self positionsCompleteRegularDiagonal: playedPositions) or: [
					(self positionsCompleteReverseDiagonal: playedPositions) ]]]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:38:26'!
errorMessageOf: aSymbolOfAPlayer

	^aSymbolOfAPlayer = #x ifTrue: (self class notXTurnErrorMessage) ifFalse: (self class notOTurnErrorMessage)
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 19:27:10'!
initialize
	xs _ Set new.
	os _ Set new.
	turn _ TicTacToeXTurn with: self.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:43:53'!
isOver
	^self XHasWon or: [self OHasWon or: [ (os, xs) size = 9 ] ].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:44:54'!
isTied
	^self isOver and: ((self OHasWon or: self XHasWon) not).! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:32:02'!
playedPositionsOf: aSymbolOfAPlayer

	^aSymbolOfAPlayer = #x ifTrue: xs ifFalse: os
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:08:05'!
positionsCompleteColumn: positions
	^(1 to: 3) anySatisfy: [:y | (positions count: [:position | position y = y ]) = 3 ]
	! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:06:10'!
positionsCompleteRegularDiagonal: positions
	^(positions includes: 1@1) and: (positions includes: 2@2) and: (positions includes: 3@3)
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:06:27'!
positionsCompleteReverseDiagonal: positions
	^(positions includes: 1@3) and: (positions includes: 2@2) and: (positions includes: 3@1)
	
	
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:06:46'!
positionsCompleteRow: positions
	^(1 to: 3) anySatisfy: [:x | (positions count: [:position | position x = x ]) = 3 ]
		
	
	
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 21:45:06'!
putOAt: aPoint
	self raiseErrorIfGameIsOver.
	self raiseErrorIfPositionTaken: aPoint.
	turn putOAt: aPoint.
	turn _ turn next.
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 21:45:10'!
putXAt: aPoint
	self raiseErrorIfGameIsOver.
	self raiseErrorIfPositionTaken: aPoint.
	turn putXAt: aPoint.
	turn _ turn next.
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 21:44:49'!
raiseErrorIfGameIsOver
	^self isOver ifTrue: [self error: self class canNotPlayWhenGameIsOverErrorMessage].
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 21:03:35'!
raiseErrorIfPositionTaken: aPoint
	^((xs includes: aPoint) or: (os includes: aPoint)) ifTrue: [self error: self class positionTakenErrorMessage].
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 19:32:53'!
turn: aTurn
	turn _ aTurn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:26:05'!
canNotPlayWhenGameIsOverErrorMessage
	^'el juego terminó'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:25:41'!
new
	^self basicNew initialize! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:49:10'!
notOTurnErrorMessage
	^'O no va'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:49:12'!
notXTurnErrorMessage
	^'X no va'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:02:17'!
positionTakenErrorMessage
	^'Posición ocupada'! !


!classDefinition: #TicTacToeTurn category: #TicTacToe!
Object subclass: #TicTacToeTurn
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTurn methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 19:24:47'!
initializeWith: aGame
	game _ aGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeTurn class' category: #TicTacToe!
TicTacToeTurn class
	instanceVariableNames: ''!

!TicTacToeTurn class methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 19:24:30'!
with: game
	^self new initializeWith: game! !


!classDefinition: #TicTacToeOTurn category: #TicTacToe!
TicTacToeTurn subclass: #TicTacToeOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeOTurn methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 21:33:58'!
next
	^(TicTacToeXTurn with: game)	
! !

!TicTacToeOTurn methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 21:43:44'!
putOAt: aPoint
	game OOO: aPoint.! !

!TicTacToeOTurn methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 19:30:26'!
putXAt: aPoint
	self error: game class notXTurnErrorMessage.
	
! !


!classDefinition: #TicTacToeXTurn category: #TicTacToe!
TicTacToeTurn subclass: #TicTacToeXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeXTurn methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 21:30:41'!
next
	^(TicTacToeOTurn with: game)
! !

!TicTacToeXTurn methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 19:31:01'!
putOAt: aPoint
	self error: game class notOTurnErrorMessage.
	
! !

!TicTacToeXTurn methodsFor: 'as yet unclassified' stamp: 'DR 5/28/2018 21:34:17'!
putXAt: aPoint
	game isOver ifTrue: [self error: game class canNotPlayWhenGameIsOverErrorMessage ].
	game XXX: aPoint.
	
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeXTurn class' category: #TicTacToe!
TicTacToeXTurn class
	instanceVariableNames: ''!

!TicTacToeXTurn class methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:54:34'!
character
	^#x! !

!TicTacToeXTurn class methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:57:48'!
nextTurn
	^TicTacToeOTurn ! !
