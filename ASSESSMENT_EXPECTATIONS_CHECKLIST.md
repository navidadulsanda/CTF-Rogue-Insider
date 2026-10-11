# Assignment 2 — Assessment Expectations: Coverage Checklist
Group 75 · Operation Rogue Insider · tick each item before recording / submitting.

## 1. The box must be built and tested (no false claims)
- [ ] All 6 stages solved end-to-end via the intended path (recorded in tests/test_results.md).
- [ ] Every flag submitted and validated live in CTFd during the video.
- [ ] reset.sh tested: a stage dirtied, reset, confirmed clean; CTFd scores survive.
- [ ] Nothing claimed in the video that isn't actually implemented and working.
- Owner: Member 4 (testing) + each member for their own stages.

## 2. Technical depth — show the BUILD and the SOLVE (not just the flag)
- [ ] For EACH stage: show how it was built (files / flag placement) AND the live solve.
- [ ] Stage 4 / Stage 5: cat the source/Dockerfile and point at the vuln + flag.
- [ ] Stages 1/2/6: inspect the artifact + reproduce-and-verify the flag planting.
- [ ] Solution path shown step by step (info gathering -> tool choice -> exploitation).
- Owner: Members 2 & 3 (challenges), Member 1 (platform build), all.

## 3. Isolation — no impact on institutional or public systems
- [ ] Box runs on a host-only VM with no internet/LAN route.
- [ ] Containers on internal:true network; egress proof (NO-EGRESS) shown.
- [ ] Only ports 8000/5000/2222 published (ss -tlnp shown).
- [ ] All targets are assets WE created (avatar, pcap, Flask app, Dockerfiles) — no real systems touched.
- [ ] rockyou.txt and other public datasets used only against our own hashes; acknowledged.
- Owner: Member 1 (isolation proof), all (keep tools pointed only at our box).

## 4. Acknowledge all external tools / frameworks / datasets / images / references
- [ ] Full list in README (section 9) AND in ACKNOWLEDGEMENTS.md.
- [ ] Each member names the tools they used, out loud, in their segment.
- [ ] The source of the avatar photo is stated (own photo / licensed / public-domain).
- Owner: Member 1 (README) + each member in their segment.

## 5. Changes vs the approved A1 design — explained and justified in the video
- [ ] Member 4 lists each deviation from A1 with a one-line justification.
- [ ] Covered: static files as CTFd downloads; internal:true vs Docker Desktop port trade-off;
      host-only VM as the isolation boundary; any tool/port substitution.
- Owner: Member 4.

## 6. Each member marked only for what they demonstrate and can explain
- [ ] Each member appears on camera (or voice intro) with student ID shown.
- [ ] Each presents their own segment in their own words (no read-out script, NO AI).
- [ ] Each wrote their own solver and can explain every line (viva-ready).
- [ ] Individual contribution is attributable — see CONTRIBUTIONS.md + git commits.
- Owner: every member.
