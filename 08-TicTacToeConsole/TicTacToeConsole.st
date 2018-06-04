!classDefinition: #TicTacToeConsoleTest category: #TicTacToe!
TestCase subclass: #TicTacToeConsoleTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeConsoleTest methodsFor: 'as yet unclassified' stamp: 'DR 5/31/2018 20:45:09'!
test01ConsoleLogsEmptyGame
	| game console |
	
	game _ TicTacToe new.
	console _ TicTacToeConsole for: game.
	
	self assert: console log isEmpty.! !

!TicTacToeConsoleTest methodsFor: 'as yet unclassified' stamp: 'DR 5/31/2018 20:44:20'!
test02ConsoleLogsXPlay
	| game console expected |
	
	game _ TicTacToe new.
	console _ TicTacToeConsole for: game.
	
	game markWithXAt: 1@1.
	
	expected _ OrderedCollection new.
	expected add: 'X marcó en 1@1'.
	expected add: 'Estado: Jugando O'.
	
	self assert: console log = expected.
! !

!TicTacToeConsoleTest methodsFor: 'as yet unclassified' stamp: 'DR 5/31/2018 20:44:14'!
test03ConsoleLogsOPlayAfterXPlay
	| game console expected |
	
	game _ TicTacToe new.
	console _ TicTacToeConsole for: game.
	
	game markWithXAt: 1@1.
	game markWithOAt: 2@1.
	
	expected _ OrderedCollection new.
	expected add: 'X marcó en 1@1'.
	expected add: 'Estado: Jugando O'.	
	expected add: 'O marcó en 2@1'.
	expected add: 'Estado: Jugando X'.
	
	self assert: console log = expected.
	
	! !

!TicTacToeConsoleTest methodsFor: 'as yet unclassified' stamp: 'DR 5/31/2018 20:44:47'!
test06ConsoleLogsXWin
	| game console expected |
	
	game _ TicTacToe new.
	console _ TicTacToeConsole for: game.
	
	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.

	
	expected _ OrderedCollection new.
	expected add: 'X marcó en 1@1'.
	expected add: 'Estado: Jugando O'.	
	expected add: 'O marcó en 2@2'.
	expected add: 'Estado: Jugando X'.
	expected add: 'X marcó en 1@2'.
	expected add: 'Estado: Jugando O'.	
	expected add: 'O marcó en 3@3'.
	expected add: 'Estado: Jugando X'.
	expected add: 'X marcó en 1@3'.
	expected add: 'Estado: Juego terminado - Ganó X!!'.	
	
	self assert: console log = expected.
	! !

!TicTacToeConsoleTest methodsFor: 'as yet unclassified' stamp: 'DR 5/31/2018 20:44:55'!
test07ConsoleLogsOWin
	| game console expected |
	
	game _ TicTacToe new.
	console _ TicTacToeConsole for: game.
	
	game markAll: { 2@3. 1@1. 2@2. 1@2. 3@3. 1@3}.

	
	expected _ OrderedCollection new.

	expected add: 'X marcó en 2@3'.
	expected add: 'Estado: Jugando O'.
	expected add: 'O marcó en 1@1'.
	expected add: 'Estado: Jugando X'.
	expected add: 'X marcó en 2@2'.
	expected add: 'Estado: Jugando O'.
	expected add: 'O marcó en 1@2'.
	expected add: 'Estado: Jugando X'.	
	expected add: 'X marcó en 3@3'.
	expected add: 'Estado: Jugando O'.
	expected add: 'O marcó en 1@3'.
	expected add: 'Estado: Juego terminado - Ganó O!!'.	
	
	self assert: console log = expected.
	! !

!TicTacToeConsoleTest methodsFor: 'as yet unclassified' stamp: 'DR 5/31/2018 20:45:01'!
test08ConsoleLogsTie
	| game console expected |
	
	game _ TicTacToe new.
	console _ TicTacToeConsole for: game.
	
	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	
	expected _ OrderedCollection new.

	expected add: 'X marcó en 2@2'.
	expected add: 'Estado: Jugando O'.
	expected add: 'O marcó en 1@1'.
	expected add: 'Estado: Jugando X'.
	expected add: 'X marcó en 1@3'.
	expected add: 'Estado: Jugando O'.
	expected add: 'O marcó en 3@1'.
	expected add: 'Estado: Jugando X'.	
	expected add: 'X marcó en 2@1'.
	expected add: 'Estado: Jugando O'.
	expected add: 'O marcó en 2@3'.
	expected add: 'Estado: Jugando X'.
	expected add: 'X marcó en 1@2'.
	expected add: 'Estado: Jugando O'.
	expected add: 'O marcó en 3@2'.
	expected add: 'Estado: Jugando X'.	
	expected add: 'X marcó en 3@3'.
	expected add: 'Estado: Juego terminado - Empate!!'.	
	
	self assert: console log = expected.
	! !


!classDefinition: #TicTacToeObserverTest category: #TicTacToe!
TestCase subclass: #TicTacToeObserverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeObserverTest methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 00:41:50'!
test01ConsoleAndViewObserveXAndOPlay
	| game console view expectedConsole expectedView |
	
	game _ TicTacToe new.
	console _ TicTacToeConsole for: game.
	view _ TicTacToeView  for: game.
	
	game markWithXAt: 1@1.
	game markWithOAt: 2@1.
	
	expectedConsole _ OrderedCollection new.
	expectedConsole add: 'X marcó en 1@1'.
	expectedConsole add: 'Estado: Jugando O'.	
	expectedConsole add: 'O marcó en 2@1'.
	expectedConsole add: 'Estado: Jugando X'.
	
	expectedView _ ' | | 
-----
 | | 
-----
X|O| 
Playing X'.
	
	self assert: console log = expectedConsole.
	self assert: view show = expectedView .
	
	! !


!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:46:50'!
test01MarkedPositionsAreEmptyInANewGame

	|game|
	
	game := TicTacToe new.
	
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:49:05'!
test02XCanPlayFirst

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: game Os isEmpty.
	
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:49:18'!
test03OCanPlayAfterX

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: 1 equals: game Os size.
	self assert: (game Os includes: 2@2).
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:49:35'!
test04XCanNotPlayTwice

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:49:48'!
test05OCanNotPlayTwice

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	self
	should: [game putOAt: 3@3]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:52:33'!
test06XCanNotPlayWhereXPlayedBefore

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	self
	should: [game putXAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:52:40'!
test07XCanNotPlayWhereOPlayedBefore

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:52:25'!
test09OCanNotPlayWhereSomeonePlayedBefore

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 3@3.
	self
	should: [game putOAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 2 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: (game Xs includes: 3@3).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:54:58'!
test10NobodyWinsIfThereIsNotThreeInARow

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	
		self deny: game OHasWon.
		self deny: game XHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:57:23'!
test11XWinsIfTheyCompleteTheFirstColumn

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 1@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:57:33'!
test12XWinsIfTheyCompleteTheSecondColumn

	|game|
	
	game := TicTacToe new.

	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 2@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:58:37'!
test13XWinsIfTheyCompleteTheThirdColumn

	|game|
	
	game := TicTacToe new.

	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:57:49'!
test14XWinsIfTheyCompleteARow

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:59:07'!
test15XWinsIfTheyCompleteTheRegularDiagonal

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
	game putXAt: 3@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:59:12'!
test16XWinsIfTheyCompleteTheReverseDiagonal

	|game|
	
	game := TicTacToe new.

	game putXAt: 3@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 1@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:59:31'!
test17OWinsIfTheyCompleteThreeInARow

	|game|
	
	game := TicTacToe new.

	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 3@3.
	game putOAt: 1@3.
	
		self assert: game OHasWon.
		self deny: game XHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:00:15'!
test18OCanNotPlayWhenXHasWon

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.	
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@1.	
	game putXAt: 1@3.

	self 
		should: [ game putOAt: 3@1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game Os size.
			self assert: (game Os includes: 2@1).
			self assert: (game Os includes: 3@1) ]
			
			! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:00:39'!
test19XCanNotPlayWhenOHasWon

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 1@3.

	self 
		should: [ game putXAt: 3@2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 3 equals: game Xs size.
			self assert: (game Xs includes: 2@2).
			self assert: (game Xs includes: 2@1).
			self assert: (game Xs includes: 3@1) ]
			
			! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:01:19'!
test20GameIsTiedIfNobodyCompletesThreeInARow

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt: 2@1.	
	game putOAt: 2@3.
	game putXAt: 1@2.	
	game putOAt: 3@2.
	game putXAt: 3@3.
	
	self assert: game isOver.
	self deny: game XHasWon. 
	self deny: game OHasWon. 
	self assert: game isTied
! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:04:02'!
test21GameIsOverIfAPlayerWins

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@2.	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	game putXAt: 3@2.	
	game putOAt: 3@1.
	game putXAt: 3@3.
	
	self assert: game XHasWon. 
	self deny: game OHasWon. 
	self deny: game isTied
! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:05:36'!
test90OCanNotPlayFirst

	|game|
	
	game := TicTacToe new.

	self
	should: [game putOAt: 3@3]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.	
		self assert: 0 equals: game Xs size.
		self assert: 0 equals: game Os size.
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:04:13'!
test91GameIsOverIfTheGameIsTied

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@2.	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	game putXAt: 3@2.	
	game putOAt: 3@1.
	game putXAt: 3@3.
	
	self assert: game isOver.! !


!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/27/2017 17:25:54'!
functionalException

	^Error - MessageNotUnderstood! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/26/2017 15:10:54'!
test01GameStartsWithAnEmptyBoarAndPlayingX

	"I initialize it on each test and not in the setUp to facilitate the restar of the test - Hernan"
	
	game _ TicTacToe new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.
	
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:35'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO

	game _ TicTacToe new.
	
	game markAll: {1@1}.

	self assertXIsMarkedOn: {1@1} andOOn: {}.
	self assertIsPlayingO

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:31'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsY

	game _ TicTacToe new.

	game markAll: { 1 @ 1. 2 @ 2 }.

	self assertXIsMarkedOn: {1@1} andOOn: {2@2}.
	self assertIsPlayingX.

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:28'!
test04CanNotMarkWithXWhenLastMarkWasX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:23'!
test05CanNotMarkWithOWhenLastMarkWasO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithOAt: 3 @ 3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:19'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:16'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:12'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.
	
	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:08'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2. 3@3 }.

	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1. 3@3} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:04'!
test10XWinsWhenCompletesRowNumber1

	game _ TicTacToe new.

	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assertXWon.
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:59'!
test11XWinsWhenCompletesRowNumber2

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 3@1. 2@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:54'!
test12XWinsWhenCompletesRowNumber3

	game _ TicTacToe new.

	game markAll: {3@1. 1@1. 3@2. 2@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:50'!
test13XWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:45'!
test14XWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 1@1. 1@2. 2@2. 1@3. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:41'!
test15XWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: { 1@3. 1@2. 2@2. 2@1. 3@ 1 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:35'!
test16OWinsWhenCompletesARow

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:31'!
test17OWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 3@3. 1@2. 2@3. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:25'!
test18OWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 3@2. 1@3. 1@2. 2@2. 1@1. 3@1 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:20'!
test19OWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: {1@2. 1@1. 1@3. 2@2. 2@1. 3@3 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:15'!
test20OCanNotPlayWhenXWon

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markWithOAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:12'!
test21XCanNotPlayWhenOWon

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 2@1. 1@2. 3@1. 1@3 }.

	self
		should: [ game markWithXAt: 3 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: { 2@2. 2@1. 3@1 } ]
		! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:08'!
test22GameCanEndUpTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self assertGameIsTied! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:01'!
test23XCanWinOnLastEmptyPosition

	game _ TicTacToe new.

	game markAll: { 2@2. 1@2. 1@1. 2@1. 1@3. 2@3. 3@2. 3@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:41:58'!
test24CanNotPlayWhenGameIsTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'JG 5/12/2018 13:23:11'!
test25CanNotMarkOutsideBoard

	game _ TicTacToe new.

	#(0 4) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:49:43'!
test26OCanNotMarkWhenGameIsOver

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !


!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:06'!
assertCanNotMarkAt: aPosition

	self assertCanNotMarkUsing: [ game markWithXAt: aPosition ].
	self assertCanNotMarkUsing: [ game markWithOAt: aPosition ].
	
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:29'!
assertCanNotMarkUsing: aMarkingClosure

	self
		should: aMarkingClosure 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionOutsideBoardErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:14'!
assertGameIsNotOver

	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:48'!
assertGameIsOver
	
	self assert: game isOver.

	self deny: game isPlayingX.
	self deny: game isPlayingO.
		
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:40:41'!
assertGameIsTied

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:13:05'!
assertIsPlayingO
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.
	self assertGameIsNotOver ! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:05'!
assertIsPlayingX
		
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:38:07'!
assertOIsMarkedOn: oPositions
		
	self assert: oPositions size equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions) isEmpty.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:32:18'!
assertOWon

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self assert: game hasPlayerOWon.
	self deny: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:56'!
assertXIsMarkedOn: xPositions

	self assert: xPositions size equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions) isEmpty.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:44'!
assertXIsMarkedOn: xPositions andOOn: oPositions
 
	self assertXIsMarkedOn: xPositions.
	self assertOIsMarkedOn: oPositions.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:30'!
assertXWon
	
	self assertGameIsOver.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.
! !


!classDefinition: #TicTacToeViewTest category: #TicTacToe!
TestCase subclass: #TicTacToeViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeViewTest methodsFor: 'as yet unclassified' stamp: 'DR 6/3/2018 19:42:30'!
test01ViewShowsEmptyGame
	| game expected view |
	
	game _ TicTacToe new.
	view _ TicTacToeView for: game.
	
	expected _ ' | | 
-----
 | | 
-----
 | | 
Playing X'.
	
	self assert: view show = expected.! !

!TicTacToeViewTest methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 01:17:55'!
test02ViewShowsXPlay
	| game expected view |
	
	game _ TicTacToe new.
	view _ TicTacToeView for: game.
	
	game markWithXAt: 1@1.
	
	expected _ ' | | 
-----
 | | 
-----
X| | 
Playing O'.
	
	self assert: view show = expected.! !

!TicTacToeViewTest methodsFor: 'as yet unclassified' stamp: 'np 6/3/2018 22:56:39'!
test06ViewShowsXPlayAndOPlay
	| game expected view |
	
	game _ TicTacToe new.
	view _ TicTacToeView for: game.
	
	game markWithXAt: 1@1.
	game markWithOAt: 2@1.
	
	expected _ ' | | 
-----
 | | 
-----
X|O| 
Playing X'.
	
	self assert: view show = expected.! !

!TicTacToeViewTest methodsFor: 'as yet unclassified' stamp: 'np 6/3/2018 23:21:46'!
test07ViewShowsXWin
	| game expected view |
	
	game _ TicTacToe new.
	view _ TicTacToeView for: game.
	
	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.
	
	expected _ 'X| |O
-----
X|O| 
-----
X| | 
X Won!!'.
	
	self assert: view show = expected.! !

!TicTacToeViewTest methodsFor: 'as yet unclassified' stamp: 'np 6/3/2018 23:29:16'!
test08ViewShowsOWin
	| game expected view |
	
	game _ TicTacToe new.
	view _ TicTacToeView for: game.
	
	game markAll: { 2@3. 1@1. 2@2. 1@2. 3@3. 1@3}.
	
	expected _ 'O|X|X
-----
O|X| 
-----
O| | 
O Won!!'.
	
	self assert: view show = expected.! !

!TicTacToeViewTest methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 01:15:01'!
test09ViewShowsTiedGame
	| game expected view |
	
	game _ TicTacToe new.
	view _ TicTacToeView for: game.
	
	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.
	
	expected _ 'X|O|X
-----
X|X|O
-----
O|X|O
Tied!!'.
	
	self assert: view show = expected.! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'state playerOPositions playerXPositions observers lastPositionPlayed lastPlayer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'basic endgame' stamp: 'jg 5/22/2018 12:36:01'!
hasCompletedRow: positions

	^ (1 to: 3) anySatisfy: [ :x | (positions count: [ :posicion | posicion x = x ]) = 3 ]! !

!TicTacToe methodsFor: 'basic endgame' stamp: 'DR 5/31/2018 00:57:48'!
hasTie
	
	^xs size = 5 and: [ os size = 4 and: [ self XHasWon not ]] " and: [ self YHasWon not ]]]"! !


!TicTacToe methodsFor: 'endgame' stamp: 'DR 5/31/2018 00:51:09'!
OHasWon
	
	^state OHasWon! !

!TicTacToe methodsFor: 'endgame' stamp: 'DR 5/31/2018 01:00:20'!
XHasWon
	
	^state XHasWon! !


!TicTacToe methodsFor: 'initialization' stamp: 'np 6/4/2018 00:38:42'!
initialize
	playerXPositions _ OrderedCollection new.
	playerOPositions _ OrderedCollection new.
	state _ PlayingX for: self.
	observers  _ Set new.! !


!TicTacToe methodsFor: 'private' stamp: 'DR 5/31/2018 01:03:39'!
addNewPosition: aPosition toList: aListOfPositions
	
	self raiseErrorIfPositionTaken: aPosition.
	aListOfPositions add: aPosition.! !

!TicTacToe methodsFor: 'private' stamp: 'DR 5/30/2018 23:51:25'!
os

	^os! !

!TicTacToe methodsFor: 'private' stamp: 'DR 5/31/2018 00:18:23'!
state: aTurn
	state _ aTurn.! !

!TicTacToe methodsFor: 'private' stamp: 'DR 5/30/2018 23:51:22'!
xs

	^xs! !


!TicTacToe methodsFor: 'positions' stamp: 'jg 5/22/2018 10:01:34'!
Os

	^os copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'jg 5/22/2018 10:01:25'!
Xs

	^xs copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'np 6/4/2018 00:10:14'!
lastPositionPlayed
	^lastPositionPlayed copy! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TicTacToe methodsFor: 'playing' stamp: 'DR 5/31/2018 00:18:31'!
putOAt: aPosition

	state putOAt: aPosition inGame: self! !

!TicTacToe methodsFor: 'playing' stamp: 'DR 5/31/2018 00:18:34'!
putXAt: aPosition

	state putXAt: aPosition inGame: self! !


!TicTacToe methodsFor: 'errors' stamp: 'DR 5/30/2018 23:51:01'!
raiseErrorIfPositionTaken: aPosition

	^((xs includes: aPosition) or: (os includes: aPosition)) ifTrue: [self error: self class positionTakenErrorMessage].
! !


!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:39'!
markAll: positions

	positions do: [ :aPosition | self markAt: aPosition ]! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:23'!
markAt: aPosition

	^state markAt: aPosition ! !

!TicTacToe methodsFor: 'marking board' stamp: 'np 6/4/2018 01:25:21'!
markWithOAt: aPosition
	lastPositionPlayed _ aPosition.
	lastPlayer _ $O.
	
	self assertIsInBoardBounds: aPosition.
	state markWithOAt: aPosition.
	
	self announceAllObservers.
	! !

!TicTacToe methodsFor: 'marking board' stamp: 'np 6/4/2018 01:25:16'!
markWithXAt: aPosition
	lastPositionPlayed _ aPosition.
	lastPlayer _ $X.

	self assertIsInBoardBounds: aPosition.
	state markWithXAt: aPosition.
	
	self announceAllObservers.
! !


!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:41:25'!
add: aPosition to: positions nextPlayerState: nextPlayingState winnerState: winnerState

	positions add: aPosition.
	state := (self stateAfterAddingTo: positions with: nextPlayingState and: winnerState) for: self
	! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/27/2017 10:26:10'!
assertIsInBoardBounds: aPosition

	(aPosition between: 1@1 and: 3@3) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'JG 5/12/2018 12:34:04'!
markWithOWhenPlayingOAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerOPositions
		nextPlayerState: PlayingX
		winnerState: PlayerOWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOWhenPlayingXAt: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXWhenPlayingOAt: aPoint
	self error: self class notXTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXWhenPlayingXAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerXPositions
		nextPlayerState: PlayingO
		winnerState: PlayerXWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:44:57'!
stateAfterAddingTo: positions with: nextPlayingState and: winnerState

	(self hasWin: positions) ifTrue: [ ^ winnerState ].
	self shouldBeTiedWhenNoOneWon ifTrue: [ ^ GameTied ].

	^ nextPlayingState.! !


!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ state hasPlayerOWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ state hasPlayerXWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:01'!
isTied
	
	^ state isTied! !


!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !


!TicTacToe methodsFor: 'testing board positions' stamp: 'HAW 10/25/2017 15:50:52'!
isTaken: aPosition
	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:22:42'!
has: positions threeOf: aPositionComponent

	^(positions collect: aPositionComponent) asBag contents values includes: 3 
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:09:34'!
hasCompletedColumn: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition x ]
	
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:25:55'!
hasCompletedDiagonal: positions 
	
	^(self hasUpDiagonal: positions) or: [self hasDownDiagonal: positions]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:47'!
hasCompletedLine: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition y ]
! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:25:48'!
hasCompletedStraightLine: positions
	
	^(self hasCompletedColumn: positions) or: [self hasCompletedLine: positions ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasUpDiagonal: positions
	
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:26:17'!
hasWin: positions

	^positions size >= 3 and: [ (self hasCompletedStraightLine: positions) or: [ self hasCompletedDiagonal: positions ]].
		
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:44:42'!
shouldBeTiedWhenNoOneWon

	^ playerXPositions size = 5 and: [ playerOPositions size = 4 ].! !


!TicTacToe methodsFor: 'observation' stamp: 'np 6/4/2018 15:01:51'!
addObserver: aTicTacToeObserver
	observers add: aTicTacToeObserver! !


!TicTacToe methodsFor: 'players' stamp: 'np 6/4/2018 00:46:08'!
currentPlayer
	self isPlayingO ifTrue: [^$O].
	self isPlayingX ifTrue: [^$X].
! !

!TicTacToe methodsFor: 'players' stamp: 'np 6/4/2018 00:11:01'!
lastPlayer
	^lastPlayer copy! !


!TicTacToe methodsFor: 'observation - private' stamp: 'np 6/4/2018 01:24:33'!
announceAllObservers

	observers do: [:anObserver | anObserver announceChange].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 00:35:14'!
new
	^self basicNew initialize! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/27/2017 10:26:31'!
positionOutsideBoardErrorMessage
	
	^'Position is outside board'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TicTacToeObserver category: #TicTacToe!
Object subclass: #TicTacToeObserver
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeObserver methodsFor: 'notification' stamp: 'np 6/4/2018 14:58:36'!
announceChange

	self subclassResponsibility! !


!classDefinition: #TicTacToeConsole category: #TicTacToe!
TicTacToeObserver subclass: #TicTacToeConsole
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeConsole methodsFor: 'observation' stamp: 'DR 5/31/2018 19:59:58'!
log
	^log copy! !


!TicTacToeConsole methodsFor: 'initialization' stamp: 'np 6/4/2018 00:33:31'!
initializeFor: aTicTacToe
	log _ OrderedCollection new.
	game _ aTicTacToe.
	^self.
	! !


!TicTacToeConsole methodsFor: 'notification' stamp: 'np 6/4/2018 00:55:42'!
announceChange

	log add: game lastPlayer asString,' marcó en ', game lastPositionPlayed asString.

	game isOver 
		ifTrue: [
			game isTied 
				ifTrue: [ log add: 'Estado: Juego terminado - Empate!!' ]
				ifFalse: [log add: 'Estado: Juego terminado - Ganó ', game lastPlayer asString, '!!' ]
		]
		ifFalse: [
			log add: 'Estado: Jugando ', game currentPlayer asString.			
		]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeConsole class' category: #TicTacToe!
TicTacToeConsole class
	instanceVariableNames: ''!

!TicTacToeConsole class methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 00:33:40'!
for: aTicTacToe

	| newConsole |
	
	newConsole _ self basicNew initializeFor: aTicTacToe.
	
	aTicTacToe addObserver: newConsole. 
	
	^newConsole
! !


!classDefinition: #TicTacToeView category: #TicTacToe!
TicTacToeObserver subclass: #TicTacToeView
	instanceVariableNames: 'board currentState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeView methodsFor: 'notification' stamp: 'np 6/4/2018 00:57:12'!
announceChange
	self markBoardAt: game lastPositionPlayed with: game lastPlayer.
	
	game isOver 
		ifTrue: [
			game isTied
				ifTrue: [currentState _ 'Tied!!']
				ifFalse: [currentState _ game lastPlayer asString, ' Won!!']
			]
		ifFalse: [
 			currentState _'Playing ', game currentPlayer asString
			]			
	
! !


!TicTacToeView methodsFor: 'initialization' stamp: 'np 6/3/2018 22:50:06'!
emptyBoard
	| anEmptyBoard |
	
	anEmptyBoard _ OrderedCollection new.
	3 timesRepeat: [ anEmptyBoard add: self emptyRow].

	^anEmptyBoard! !

!TicTacToeView methodsFor: 'initialization' stamp: 'np 6/3/2018 22:50:13'!
emptyRow
	| aRow |
	
	aRow _ OrderedCollection new.
	3 timesRepeat: [aRow add: $ .].
	
	^aRow! !

!TicTacToeView methodsFor: 'initialization' stamp: 'np 6/4/2018 00:22:56'!
initializeFor: aTicTacToe

	game _ aTicTacToe.
	board _ self emptyBoard.
	currentState _ 'Playing X'.
! !


!TicTacToeView methodsFor: 'drawing - private' stamp: 'DR 6/3/2018 21:52:18'!
markBoardAt: aPosition with: aCharacter

	((board at: aPosition y) at: aPosition x put: aCharacter)! !

!TicTacToeView methodsFor: 'drawing - private' stamp: 'np 6/4/2018 01:05:10'!
printBoard
	^String streamContents: [ :aStream |
		self from: 3 to: 1 step: -1
			execute: [ :row | self printRow: row into: aStream ]
			separatedBy: [ self printRowSeparatorInto: aStream.].
		]! !

!TicTacToeView methodsFor: 'drawing - private' stamp: 'np 6/4/2018 01:02:46'!
printRow: row into: aStream
	self from: 1 to: 3 step: 1
		execute: [ :column | aStream nextPut: ((board at: row) at: column). ]
		separatedBy: [ aStream nextPut: $|.].! !

!TicTacToeView methodsFor: 'drawing - private' stamp: 'DR 6/3/2018 21:56:16'!
printRowSeparatorInto: aStream
	aStream nextPutAll: '
-----
'.! !


!TicTacToeView methodsFor: 'observation' stamp: 'np 6/4/2018 00:20:55'!
show
	^ self printBoard,'
', currentState copy! !


!TicTacToeView methodsFor: 'utils - private' stamp: 'np 6/4/2018 01:02:27'!
from: aBeginning to: anEnd step: aStep execute: aClosure separatedBy: aSeparatorClosure
	aBeginning to: anEnd by: aStep do: [ :index |
		aClosure value: index.
		(index ~= anEnd) ifTrue: [ aSeparatorClosure value ]. 
	].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeView class' category: #TicTacToe!
TicTacToeView class
	instanceVariableNames: ''!

!TicTacToeView class methodsFor: 'as yet unclassified' stamp: 'np 6/3/2018 23:02:56'!
for: aTicTacToe

	| newView |
	
	newView _ self basicNew initializeFor: aTicTacToe.
	
	aTicTacToe addObserver: newView. 
	
	^newView
! !


!classDefinition: #TicTacToeState category: #TicTacToe!
Object subclass: #TicTacToeState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeState methodsFor: 'playing' stamp: 'DR 5/31/2018 00:51:57'!
OHasWon

	self shouldBeImplemented.! !

!TicTacToeState methodsFor: 'playing' stamp: 'DR 5/31/2018 00:15:35'!
putOAt: aPosition inGame: aGame

	self shouldBeImplemented.! !

!TicTacToeState methodsFor: 'playing' stamp: 'DR 5/31/2018 00:15:37'!
putXAt: aPosition inGame: aGame

	self shouldBeImplemented.! !


!TicTacToeState methodsFor: 'transition' stamp: 'DR 5/31/2018 00:15:28'!
nextStateOf: aGame

	self shouldBeImplemented.! !


!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerOWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerXWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isOver
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isTied
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingO
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingX
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:31'!
markAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	self subclassResponsibility.! !


!TicTacToeState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToe!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'HAW 10/25/2017 13:05:29'!
for: aTicTacToe 
	
	^self new initializeFor: aTicTacToe ! !


!classDefinition: #GameOverState category: #TicTacToe!
TicTacToeState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 11:53:57'!
isOver
	
	^true! !


!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:23'!
isPlayingO
	
	^false! !

!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:27'!
isPlayingX
	
	^false! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:09'!
markAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #GameTied category: #TicTacToe!
GameOverState subclass: #GameTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:49'!
isTied
	
	^true! !


!classDefinition: #PlayerOWon category: #TicTacToe!
GameOverState subclass: #PlayerOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ true.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:06:24'!
isTied
	
	^false! !


!classDefinition: #PlayerXWon category: #TicTacToe!
GameOverState subclass: #PlayerXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ true.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:25:44'!
isTied
	
	^false! !


!classDefinition: #PlayingState category: #TicTacToe!
TicTacToeState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:10'!
hasPlayerOWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:17'!
hasPlayerXWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:26'!
isOver
	
	^false! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:52'!
isTied
	
	^false! !


!classDefinition: #PlayingO category: #TicTacToe!
PlayingState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:27'!
isPlayingX
	
	^false! !


!PlayingO methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:13'!
markAt: aPosition

	^game markWithOAt: aPosition ! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:45'!
markWithOAt: aPosition
	game markWithOWhenPlayingOAt: aPosition.! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXAt: aPosition
	game markWithXWhenPlayingOAt: aPosition.! !


!classDefinition: #PlayingX category: #TicTacToe!
PlayingState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:50'!
isPlayingO
	
	^false! !

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:17'!
markAt: aPosition

	^game markWithXAt: aPosition ! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOAt: aPosition
	game markWithOWhenPlayingXAt: aPosition.! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXAt: aPosition
	game markWithXWhenPlayingXAt: aPosition.! !
