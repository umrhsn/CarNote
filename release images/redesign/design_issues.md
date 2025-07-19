UX Audit of a Car Maintenance Tracking App Screen Key ProblemsLow ContrasttextThe light grey
informational text does not have sufficient contrast against its light background, failing WCAG
accessibility standards and making it difficult to read.Low ContrasttextThe red informational text
lacks sufficient contrast against its light pink background, which is a critical accessibility
failure, especially for users with vision impairments.Low ContrasttextThe yellow text on the light
beige background has a low contrast ratio, making it difficult for users with visual impairments to
read.Low ContrasttextThe red text on the light pink background has insufficient contrast, making it
hard to read for many users and failing accessibility guidelines for normal-sized text.Ambiguous
Icon Functionsicon_barThe icons in the top bar lack text labels, making their purpose unclear. Users
may not understand what they are viewing, copying, or deleting, which can cause confusion.Small
Touch TargeticonThe edit icon is small, making it difficult to tap accurately. Touch targets should
be at least 44x44 pixels to ensure usability.Small Touch TargeticonThe delete icon has a small touch
target, which can lead to user frustration from missed taps. Consider increasing the tappable
area.Small Touch TargeticonThe edit icon is small, making it difficult to tap accurately. Touch
targets should be at least 44x44 pixels to ensure usability.Small Touch TargeticonThe delete icon
has a small touch target, which can lead to user frustration from missed taps. Consider increasing
the tappable area.Inconsistent AlignmenttextThe text labels within the cards are not vertically
aligned, creating a slightly disorganized look. Consistent alignment improves scannability and
professionalism. Hello! I'm Pixels Perfect, and it's a pleasure to take a look at your car
maintenance tracking app. You've got a fantastic, clean foundation here. The core function is clear,
and the use of cards to separate information is a great choice. Let's dive in and see how we can
polish this design to make it even more effective and accessible for everyone!
Overall Impression
The design is minimalist and task-oriented, which is excellent. Users can quickly see the current
status of their vehicle's maintenance needs. The color-coding for 'due soon' (yellow) and '
overdue' (red) is an intuitive pattern. My main recommendations will focus on boosting
accessibility—specifically text contrast—and refining some interaction details to enhance usability.
Deep Dive Audit
Accessibility: The Critical Path to Inclusion
This is the most crucial area for improvement. Several text elements have insufficient contrast,
which can make the app unusable for people with visual impairments.

Critical Contrast Issues: The informational text and status labels currently fail to meet the
minimum contrast ratio required by the Web Content Accessibility Guidelines (WCAG).
Yellow 'Remaining' Label: The yellow text (estimated at #B78D0A) on the light beige background (
#FAF7EF) has a contrast ratio of approximately 3.46:1. This fails the WCAG AA standard of 4.5:1.
Actionable Fix: Change the text color to a darker shade, like #8A6900. This simple change would
boost the contrast ratio to a much healthier 6.2:1, making it easily readable.

Grey Help Text: The subtle grey text (#888888) under the 'Engine Oil' card has a contrast ratio of
about 3.39:1 against its background (#FAF7EF), also failing WCAG AA.
Actionable Fix: Please darken this text to at least #757575, which achieves a passing ratio of 4.54:
1.

Red Status Labels & Help Text: The red text (#D32F2F) on the light pink background (#FDF5F6) has a
ratio of 3.99:1. This is a failure for normal-sized text.
Actionable Fix: Deepen the red to #C01A1A. This improves the ratio to 4.8:1, ensuring it's
accessible while still clearly communicating a warning.

Resource: You can check your color combinations yourself using a tool like the WebAIM Contrast
Checker.
User Control & Interaction
Giving users clear, easy-to-use controls is key to a frictionless experience.

Small Touch Targets: The 'edit' and 'delete' icons are quite small. The recommended minimum size for
a touch target is 44x44 pixels (for iOS) or 48x48dp (for Android) to prevent frustrating mistaps.
How to Fix: Increase the tappable area around these icons. Even if the icon's visual size remains
the same, the invisible touch target can be larger.

Ambiguous Icons: The row of icons at the top (Translate, View, Copy, Delete, Info) lack context.
What is the user deleting or copying? Is it the entire car profile or a specific entry? This
ambiguity can cause hesitation.
How to Fix: Consider adding text labels below the icons for clarity or using a 'kebab' (three-dot)
menu that opens a list with text labels like "Edit Vehicle," "Delete Vehicle," etc.

Layout, Spacing, and Consistency
A well-organized layout helps users process information effortlessly.

Alignment: The vertical alignment of the field labels ('Last changed at', 'Remaining', 'Exceeded
by') is slightly inconsistent between cards. This creates minor visual noise.
How to Fix: Ensure all these labels share a common vertical starting point. A consistent grid system
will solve this naturally and make the entire screen feel more polished and professional.

Summary & Key Recommendations
You're on the right track to creating a very helpful tool! The information architecture is solid. To
elevate this design from good to great, I'd prioritize these three things:

Fix all text contrast issues. This is a critical accessibility requirement.
Increase the touch target size for all interactive icons to improve usability.
Clarify the function of the top-level icons to reduce user uncertainty.

Keep up the fantastic work! These refinements will ensure your app is not only beautiful but also
usable and welcoming for every driver.