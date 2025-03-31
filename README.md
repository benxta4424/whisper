
# About the Project

Welcome to Whisper, a full-stack social media app designed to be different—minimal, intuitive, and focused on real connections.

In a world of endless feeds and overwhelming algorithms, Whisper takes a step back. No clutter, no noise—just a clean, straightforward way to share thoughts, engage in meaningful conversations, and connect without distractions.

# Why Whisper?

* Simpler by Design – Thoughtful UI, less scrolling, more substance.

* Authentic Interactions – Fewer bots, fewer ads, more real conversations.

* Fast & Lightweight – Rails-powered backend for smooth performance.

Whether you're here to share ideas, follow close friends, or just take a break from the chaos of traditional social media, Whisper keeps it effortless.

# Whisper Development Journey
How the Project Evolved

I built Whisper step by step, focusing on a clean, real-time social experience with Rails and Hotwire:

    Layout & Authentication

        * Started with a minimalist UI design.

        * Integrated Devise for user authentication.

    Core Features

        * Posts: Implemented CRUD for the current user’s posts.

        * Likes: Added instant likes/dislikes using Stimulus.

        * Comments: Enabled real-time comments with Turbo Streams.

        User Profiles & Following:

            * Users can follow/unfollow others.

            * The feed merges posts from the current user and followed users chronologically.

    Database & Associations

        * Structured models in true "Rails way" (e.g., User -> Post -> Comment/Like).

# Key Challenges & Solutions

1. Turbo Frame Conflicts

    Issue: Frames failed due to duplicate JS loading (javascript_importmap_tags + javascript_include_tag).

    Fix: Removed javascript_include_tag—Stick with importmap for modern Rails.

2. Lazy-Loading Turbo Frames

    Goal: Real-time posts/comments without reloads (SPA-like).

    Mistake: Tried rendering frames directly without Turbo Streams.

    Fix: Rendered forms in dedicated routes (e.g., new_post_path) AND
    used turbo_frame_tag to target containers + Turbo Streams for dynamic updates.

3. Mobile-First Styling

    Struggle: Tailwind felt restrictive for complex layouts.

    Solution: Switched to vanilla CSS for finer control (media queries, animations).

4. Form Actions (Submit-End)

    Problem: Needed post-submit actions (e.g., clear input fields).

    Mistake: Overrode form submission with Stimulus click events.

    Fix: Discovered submit-end via this StackOverflow thread:
    
        https://stackoverflow.com/questions/70732712/reset-form-in-hotwire

    Example: Cleared comment fields after submission.

# Next Steps & Ideas
* Live Chat: Implement WebSockets (Action Cable) for DMs.

* APIs:

        Weather: Display local weather for the current user.

        News Feed: Curated headlines at the bottom of the feed.

* Additional Features:

        Bookmarks: Save posts privately.

        Dark Mode: Toggleable UI theme.

## Final Thoughts

* This project has been a fantastic learning experience—especially mastering Hotwire’s real-time magic. 
* The project will be uploaded soon on Render or Herku

P.S. I’m open to suggestions or feedback! :)
