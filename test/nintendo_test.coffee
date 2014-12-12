path = require "path"
chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = require('chai').expect
helper = require 'hubot-mock-adapter-helper'
TextMessage= require("hubot/src/message").TextMessage


describe 'search nintendo games', ->
  {robot, user, adapter} = {}

  beforeEach (done)->
    helper.setupRobot (ret) ->
      {robot, user, adapter} = ret
      require('../src/nintendo')(robot)
      do done

  afterEach ->
    robot.shutdown()

  describe "nintendo search", ->

    it "successful response", (done)->
      adapter.on "reply", (envelop, strings) ->
        try
          expect(strings[0]).to.not.equal("I didn't find any games with 'asdajwXBOX'")
          done()

        catch e
          done e

      adapter.receive(new TextMessage(user, "hubot nintendo search mario"))

    it "successful response with multiple words", (done)->
      adapter.on "reply", (envelop, strings) ->
        try
          expect(strings[0]).to.not.equal("I didn't find any games with 'hyrule warrios'")
          done()

        catch e
          done e

      adapter.receive(new TextMessage(user, "hubot nintendo search hyrule warriors"))

    it "empty response", (done)->

      adapter.on "reply", (envelop, strings) ->
        try
          expect(strings[0]).to.equal("I didn't find any games with 'asdajwXBOX'")
          done()

        catch e
          done e

      adapter.receive(new TextMessage(user, "hubot nintendo search asdajwXBOX"))

  describe "game show (.*)", (done)->
    it "successful response", (done)->
      adapter.on "reply", (envelop, strings) ->
        try
          expect(strings[0]).to.not.equal("I didn't find any games with 'ZXkoJ75AEzAds5-6L0VvlgY-zUyOTGE0'")
          done()

        catch e
          done e

      adapter.receive(new TextMessage(user, "hubot nintendo show ZXkoJ75AEzAds5-6L0VvlgY-zUyOTGE0"))





