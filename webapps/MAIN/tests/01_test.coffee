chai.should()

describe "foo", ->
    it "should be equal to foo", ->
        "foo".should.equal "foo"
    it "should be a string", ->
        "foo".should.be.a "string"
