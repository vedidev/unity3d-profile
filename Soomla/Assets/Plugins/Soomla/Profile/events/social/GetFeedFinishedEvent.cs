using UnityEngine;
using System;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class GetFeedFinishedEvent : BaseSocialActionEvent
    {
        public readonly List<string> Posts;
        public readonly bool HasMore;

        public GetFeedFinishedEvent(Provider provider,
                                    SocialActionType getFeedType,
                                    List<string> feedPosts, string payload, bool hasMore) : base(provider, getFeedType, payload)
        {
            Posts = feedPosts;
            HasMore = hasMore;
        }
    }
}
