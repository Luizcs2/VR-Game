# CS423_Project



## Getting started

Useful context!!! https://docs.godotengine.org/en/stable/getting_started/first_3d_game/index.html

Install git, godot and blender.

Set up an SSH key for your profile. https://docs.gitlab.com/user/ssh/

Clone the repo with the following cmd command:
```
git clone git@gitlab.cs.nuim.ie:u200317/cs423_project.git
```

Create a different branch to work on than the main branch to avoid clashing with other devs using the following command:
```
git checkout -b BranchName
```
Remove the "-b" attribute to change between branches without creating a new one.

## Pull code updates
```
git fetch

git pull
```
Git fetch just fetches the updates from the repo, while git pull both fetches and merges the updates with your local repo.

## Push code
Save code changes and push them to the repo with the following commands:
```
git add --all
git commit -m "commit message"
git push
```

## Import cloned repo into godot
1. Find the folder your project is kept in
2. Open godot and import the project folder that contains the .project file

## Running project
Press the play button! 

Non-vr controls have been implemented so you can navigate the scene with WASD and your mouse