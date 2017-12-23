function [filename] = createJournal0012_ITLL(airfoil, iterations, aoa, firstFile)

%% Define filenames for saving stuff
filename = [airfoil '_AOA' num2str(aoa) '_journal'];
filename_dragPlot = [airfoil '_dragplot_AOA' num2str(aoa) '.jpg'];
filename_liftPlot = [airfoil '_liftplot_AOA' num2str(aoa) '.jpg'];
filename_residualsPlot = [airfoil '_reportFile_AOA' num2str(aoa) '.out'];
filename_caseAndData = [airfoil '_CaseAndData_AOA' num2str(aoa)];
filename_reportFile = [airfoil '_reportFile_AOA' num2str(aoa) '.out'];


%% Open file for writing
fileID = fopen(filename, 'w+');


%% Begin commands
if firstFile
   fprintf(fileID, '/file/set-tui-version "18.2"\n');
end

% fprintf(fileID, '/file/read-case "\\\\itll-fs01\\student profiles\\keco8012\\Desktop\\CFD Project _ITLL\\NACA 4412\\NACA4412_setup.cas" \n');
fprintf(fileID, '/file/read-case "\\\\itll-fs01\\student profiles\\keco8012\\Desktop\\CFD Project _ITLL\\NACA 0012\\NACA0012_setup.cas" \n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Setup|Boundary Conditions|farfield (pressure-far-field, id=2)"))\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Setup|Boundary Conditions|farfield (pressure-far-field, id=2)"))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "NavigationPane*List_Tree1")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Setup|Boundary Conditions|farfield (pressure-far-field, id=2)"))\n');
fprintf(fileID, '(cx-gui-do cx-set-real-entry-list "Pressure Far-Field*Frame3*Frame1(Momentum)*Table1*Table14*RealEntry2(X-Component of Flow Direction)" ''( %f))\n', cosd(aoa));
fprintf(fileID, '(cx-gui-do cx-set-real-entry-list "Pressure Far-Field*Frame3*Frame1(Momentum)*Table1*Table15*RealEntry2(Y-Component of Flow Direction)" ''( %f))\n', sind(aoa));
fprintf(fileID, '(cx-gui-do cx-activate-item "Pressure Far-Field*PanelButtons*PushButton1(OK)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Report Definitions"))\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Report Definitions"))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "NavigationPane*List_Tree1")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Report Definitions"))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Report Definitions*Table1*ButtonBox3*PushButton1(New)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "MenuBar*Force ReportSubMenu*Drag...")\n');
fprintf(fileID, '(cx-gui-do cx-set-text-entry "Drag Report Definition*Table1*TextEntry3(Name)" "drag_%s")\n', filename);
fprintf(fileID, '(cx-gui-do cx-activate-item "Drag Report Definition*Table1*TextEntry3(Name)")\n');
fprintf(fileID, '(cx-gui-do cx-set-real-entry-list "Drag Report Definition*Table1*Table1*Table2(Force Vector)*RealEntry1(X)" ''( %f))\n', cosd(aoa));
fprintf(fileID, '(cx-gui-do cx-set-real-entry-list "Drag Report Definition*Table1*Table1*Table2(Force Vector)*RealEntry2(Y)" ''( %f))\n', sind(aoa));
fprintf(fileID, '(cx-gui-do cx-set-toggle-button2 "Drag Report Definition*Table1*Table1*Table5(Create)*CheckButton2(Report Plot)" #t)\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Drag Report Definition*Table1*Table1*Table5(Create)*CheckButton2(Report Plot)")\n');
fprintf(fileID, '(cx-gui-do cx-set-toggle-button2 "Drag Report Definition*Table1*Table1*Table5(Create)*CheckButton4(Print to Console)" #t)\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Drag Report Definition*Table1*Table1*Table5(Create)*CheckButton4(Print to Console)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-selections "Drag Report Definition*Table1*Table2*List2(Wall Zones)" ''( 0))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Drag Report Definition*Table1*Table2*List2(Wall Zones)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Drag Report Definition*PanelButtons*PushButton1(OK)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Report Definitions*Table1*ButtonBox3*PushButton1(New)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "MenuBar*Force ReportSubMenu*Lift...")\n');
fprintf(fileID, '(cx-gui-do cx-set-text-entry "Lift Report Definition*Table1*TextEntry3(Name)" "lift_%s")\n', filename);
fprintf(fileID, '(cx-gui-do cx-activate-item "Lift Report Definition*Table1*TextEntry3(Name)")\n');
fprintf(fileID, '(cx-gui-do cx-set-real-entry-list "Lift Report Definition*Table1*Table1*Table2(Force Vector)*RealEntry1(X)" ''( %f))\n', -sind(aoa));
fprintf(fileID, '(cx-gui-do cx-set-real-entry-list "Lift Report Definition*Table1*Table1*Table2(Force Vector)*RealEntry2(Y)" ''( %f))\n', cosd(aoa));
fprintf(fileID, '(cx-gui-do cx-set-toggle-button2 "Lift Report Definition*Table1*Table1*Table5(Create)*CheckButton2(Report Plot)" #t)\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Lift Report Definition*Table1*Table1*Table5(Create)*CheckButton2(Report Plot)")\n');
fprintf(fileID, '(cx-gui-do cx-set-toggle-button2 "Lift Report Definition*Table1*Table1*Table5(Create)*CheckButton4(Print to Console)" #t)\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Lift Report Definition*Table1*Table1*Table5(Create)*CheckButton4(Print to Console)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-selections "Lift Report Definition*Table1*Table2*List2(Wall Zones)" ''( 0))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Lift Report Definition*Table1*Table2*List2(Wall Zones)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Lift Report Definition*PanelButtons*PushButton1(OK)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-selections "Report Definitions*Table1*List1(Report Definitions)" ''( 0))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Report Definitions*Table1*List1(Report Definitions)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-selections "Report Definitions*Table1*List1(Report Definitions)" ''( 0 1))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Report Definitions*Table1*List1(Report Definitions)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Report Definitions*PanelButtons*PushButton1(Close)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Monitors|Residual"))\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Monitors|Residual"))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "NavigationPane*List_Tree1")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Monitors|Residual"))\n');
fprintf(fileID, '(cx-gui-do cx-set-real-entry-list "Residual Monitors*Table1*Table2*Table1*Table1(Equations)*RealEntry11" ''( 1e-06))\n');
fprintf(fileID, '(cx-gui-do cx-set-real-entry-list "Residual Monitors*Table1*Table2*Table1*Table1(Equations)*RealEntry17" ''( 1e-06))\n');
fprintf(fileID, '(cx-gui-do cx-set-real-entry-list "Residual Monitors*Table1*Table2*Table1*Table1(Equations)*RealEntry23" ''( 1e-06))\n');
fprintf(fileID, '(cx-gui-do cx-set-real-entry-list "Residual Monitors*Table1*Table2*Table1*Table1(Equations)*RealEntry35" ''( 1e-06))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Residual Monitors*PanelButtons*PushButton1(OK)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Monitors|Report Files"))\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Monitors|Report Files"))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "NavigationPane*List_Tree1")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Monitors|Report Files"))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Report File Definitions*Table1*ButtonBox3*PushButton1(New)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-selections "New Report File*Table1*List2(Available Report Definitions)" ''( 0))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "New Report File*Table1*List2(Available Report Definitions)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-selections "New Report File*Table1*List2(Available Report Definitions)" ''( 0 1))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "New Report File*Table1*List2(Available Report Definitions)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "New Report File*Table1*Table4*PushButton1( Add>>)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-selections "New Report File*Table1*List3(Selected Report Definitions)" ''( 0))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "New Report File*Table1*List3(Selected Report Definitions)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-selections "New Report File*Table1*List3(Selected Report Definitions)" ''( 0 1))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "New Report File*Table1*List3(Selected Report Definitions)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "New Report File*Table1*Table6(Output File Base Name)*PushButton3(Browse)")\n');
fprintf(fileID, '(cx-gui-do cx-set-file-dialog-entries "Select File" ''( "Z:/Desktop/CFD Project _ITLL/NACA 4412/%s") "Output Files (*.out *.xy )")\n', filename_reportFile);
fprintf(fileID, '(cx-gui-do cx-activate-item "New Report File*PanelButtons*PushButton1(OK)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-selections "Report File Definitions*Table1*List1(Report Files)" ''( 0))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Report File Definitions*Table1*List1(Report Files)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Report File Definitions*PanelButtons*PushButton1(Close)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Initialization"))\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Initialization"))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "NavigationPane*List_Tree1")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Initialization"))\n');
fprintf(fileID, '(cx-gui-do cx-set-toggle-button2 "Solution Initialization*Table1*ToggleBox3(Initialization Methods)*Standard Initialization" #t)\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Solution Initialization*Table1*ToggleBox3(Initialization Methods)*Standard Initialization")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-selections "Solution Initialization*Table1*DropDownList1(Compute from)" ''( 1))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Solution Initialization*Table1*DropDownList1(Compute from)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Solution Initialization*Table1*ButtonBox8*PushButton1(Initialize)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Run Calculation"))\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Run Calculation"))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "NavigationPane*List_Tree1")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Run Calculation"))\n');
fprintf(fileID, '(cx-gui-do cx-set-integer-entry "Run Calculation*Table1*IntegerEntry10(Number of Iterations)" %f)\n', iterations);
fprintf(fileID, '(cx-gui-do cx-activate-item "Run Calculation*Table1*IntegerEntry10(Number of Iterations)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Run Calculation*Table1*PushButton22(Calculate)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list ))\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list ))\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list ))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Information*OK")\n');

fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Report Definitions|drag_%s"))\n', filename);
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Report Definitions|drag_%s"))\n', filename);
fprintf(fileID, '(cx-gui-do cx-activate-item "NavigationPane*List_Tree1")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Report Definitions|drag_%s"))\n', filename);
fprintf(fileID, '(cx-gui-do cx-activate-item "Drag Report Definition*PanelButtons*PushButton6(Compute)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Drag Report Definition*PanelButtons*PushButton1(OK)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Report Definitions|lift_%s"))\n', filename);
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Report Definitions|lift_%s"))\n', filename);
fprintf(fileID, '(cx-gui-do cx-activate-item "NavigationPane*List_Tree1")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list "Solution|Report Definitions|lift_%s"))\n', filename);
fprintf(fileID, '(cx-gui-do cx-activate-item "Lift Report Definition*PanelButtons*PushButton6(Compute)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Lift Report Definition*PanelButtons*PushButton1(OK)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "MenuBar*FileMenu*Save Picture...")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Save Picture*PanelButtons*PushButton1(OK)")\n');
fprintf(fileID, '(cx-gui-do cx-set-file-dialog-entries "Select File" ''( "/itll-fs01/student profiles/keco8012/Desktop/CFD Project _ITLL/NACA 4412/%s") "Hardcopy Files (*.jpg)")\n', filename_residualsPlot);
fprintf(fileID, '(cx-gui-do cx-activate-item "Save Picture*PanelButtons*PushButton2(Cancel)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list ))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "MenuBar*FileMenu*Save Picture...")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Save Picture*PanelButtons*PushButton1(OK)")\n');
fprintf(fileID, '(cx-gui-do cx-set-file-dialog-entries "Select File" ''( "Z:/Desktop/CFD Project _ITLL/NACA 4412/%s") "Hardcopy Files (*.jpg)")\n', filename_dragPlot);
fprintf(fileID, '(cx-gui-do cx-activate-item "Save Picture*PanelButtons*PushButton2(Cancel)")\n');
fprintf(fileID, '(cx-gui-do cx-set-list-tree-selections "NavigationPane*List_Tree1" (list ))\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "MenuBar*FileMenu*Save Picture...")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "Save Picture*PanelButtons*PushButton1(OK)")\n');
fprintf(fileID, '(cx-gui-do cx-set-file-dialog-entries "Select File" ''( "%s") "Hardcopy Files (*.jpg)")\n', filename_liftPlot);
fprintf(fileID, '(cx-gui-do cx-activate-item "Save Picture*PanelButtons*PushButton2(Cancel)")\n');
fprintf(fileID, '(cx-gui-do cx-activate-item "MenuBar*WriteSubMenu*Case & Data...")\n');
fprintf(fileID, '(cx-gui-do cx-set-file-dialog-entries "Select File" ''( "//itll-fs01/student profiles/keco8012/Desktop/CFD Project _ITLL/NACA 4412/%s.cas") "Case/Data Files (*.cas* *.dat* )")\n', filename_caseAndData);

end