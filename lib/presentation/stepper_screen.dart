import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepperScreen extends StatefulWidget {
  const StepperScreen({Key? key}) : super(key: key);

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  int activeStep = 0;
  int activeStep2 = 0;
  int reachedStep = 0;
  int upperBound = 5;

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          backgroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: 100,
                        child: EasyStepper(
                          lineType: LineType.dotted,
                          activeStep: activeStep,
                          direction: Axis.vertical,
                          unreachedStepIconColor: Colors.white,
                          unreachedStepBorderColor: Colors.black54,
                          finishedStepBackgroundColor: Colors.deepPurple,
                          unreachedStepBackgroundColor: Colors.deepOrange,
                          finishedStepTextColor: Colors.black,
                          showTitle: true,
                          lineLength: 40,
                          lineThickness: 2,
                          internalPadding: 60,
                          onStepReached: (index) =>
                              setState(() => activeStep = index),
                          steps: const [
                            EasyStep(
                              icon: Icon(CupertinoIcons.cart),
                              title: '기본정보',
                              activeIcon: Icon(CupertinoIcons.cart),
                            ),
                            EasyStep(
                              icon: Icon(Icons.file_present),
                              activeIcon: Icon(Icons.file_present),
                              title: '준비상태',
                            ),
                            EasyStep(
                              icon: Icon(Icons.filter_center_focus_sharp),
                              activeIcon: Icon(Icons.filter_center_focus_sharp),
                              title: '프로젝트 상세',
                            ),
                            EasyStep(
                              icon: Icon(Icons.check_circle_outline),
                              activeIcon: Icon(Icons.check_circle_outline),
                              title: '완료',
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                VerticalDivider(width: 2, thickness: 1,),
                Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [content(activeStep)],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _allowTabStepping(int index) => index <= reachedStep;

  /// Returns the next button.
  Widget _nextStep() {
    return IconButton(
      onPressed: () {
        if (activeStep2 < upperBound) {
          setState(() {
            ++activeStep2;
            if (reachedStep < activeStep2) {
              reachedStep = activeStep2;
            }
          });
        }
      },
      icon: const Icon(Icons.arrow_forward_ios),
    );
  }

  /// Returns the previous button.
  Widget _previousStep() {
    return IconButton(
      onPressed: () {
        if (activeStep2 > 0) {
          setState(() => --activeStep2);
        }
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  Widget content(int activeStep) {
    switch (activeStep) {
      case 0:
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text("기본 정보", style: TextStyle(fontSize: 24,), ),
              ),
              Divider(height: 0, thickness: 1,),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text.rich(
                  TextSpan(
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      text: "프로젝트 제목",
                    children: [
                      TextSpan(
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                          text: " *"
                      )
                    ]
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              )
                          )
                      )
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text.rich(
                      TextSpan(
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          text: "프로젝트 카테고리",
                          children: [
                            TextSpan(
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                                text: " *"
                            )
                          ]
                      )
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text("해당하는 프로젝트 카테고리를 모두 선택해주세요.", style: TextStyle(fontSize: 16,),),
              ),
              Container(
                width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey, width: 1)
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Checkbox(
                          checkColor: Colors.white,  // color of tick Mark
                          activeColor: Colors.black,
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          }
                      ),
                    ),
                    const Positioned(
                      top: 15,
                      left: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.account_box_rounded, size: 50,),
                          Text("개발", style: TextStyle(fontSize: 16,),),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey, width: 1)
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Checkbox(
                            checkColor: Colors.white,  // color of tick Mark
                            activeColor: Colors.black,
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            }
                        ),
                      ),
                      const Positioned(
                        top: 15,
                        left: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_box_rounded, size: 50,),
                            Text("개발", style: TextStyle(fontSize: 16,),),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
              
            ],
          ),
        );
      case 1:
        return Container(
          child: Text(activeStep.toString()),
        );
      case 2:
        return Container(
          child: Text(activeStep.toString()),
        );
      case 3:
        return Container(
          child: Text(activeStep.toString()),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
