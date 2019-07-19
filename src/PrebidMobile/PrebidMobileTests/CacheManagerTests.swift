/*   Copyright 2018-2019 Prebid.org, Inc.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import XCTest
@testable import PrebidMobile

class CacheManagerTests: XCTestCase {

    /// Mock the cache manager window protocol for testing
    class CacheManagerProtocolMock : CacheManagerWindowProtocol {
        func addSubview(_ view: UIView) {
            // Do nothing, we don't need to add the view to something.
        }
    }

    override func setUp() {
        // Put setUp code here.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveBid() {
        let bid = mockBid()
        let manager = CacheManager(window: CacheManagerProtocolMock())
        let bids:[Bid] = [bid];
        let expected = expectation(description: "Completion callback for `saveBids`.")

        manager.saveBids(bids: bids, completion: {
            expected.fulfill()
        })

        waitForExpectations(timeout: 3)
    }

    /// Return a mocked bid
    func mockBid() -> Bid
    {
        let bidDictionary:NSDictionary = [
            "id": "4761106207662573395",
            "impid": "Banner_300x250",
            "price": 0.5,
            "adm": "<script src=\"hello world\">this is an mock ad<script>",
            "adid": "113276871",
            "adomain": [
                "appnexus.com"
            ],
            "iurl": "https:lax1-ib.adnxs.comcr?id=113276871",
            "cid": "9325",
            "crid": "113276871",
            "w": 300,
            "h": 250,
            "ext": [
                "prebid": [
                    "targeting": [
                        "hb_bidder_appnexus": "appnexus",
                        "hb_cache_id_appnexus": "f5b7ff9f-4311-459d-a5ac-5d4d3d034e47",
                        "hb_env_appnexus": "mobile-app",
                        "hb_pb_appnexus": "0.50",
                        "hb_size_appnexus": "300x250"
                    ]
                ]
            ],
            "cache_id": "dummy" // Non official? not sure where this comes from
        ]
        return Bid(bidDictionary: bidDictionary)
    }
}
