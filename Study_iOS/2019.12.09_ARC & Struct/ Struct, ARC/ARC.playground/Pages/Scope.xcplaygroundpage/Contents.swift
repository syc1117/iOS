//: [Previous](@previous)
/*:
 ---
 # Scope
 - 스코프 범위에 의한 할당 및 해제
 ---
 */
//수동 참조카운트 관리: MRR (Manual Retain-Release) / MRC (Manual Referece Counting)
//RC(Reference Counting) 를 통해 메모리를 수동으로 관리하는 방식 retain / release / autorelease 등의 메모리 관리 코드를 직접 호출 개발자가 명시적으로 RC 를 증가시키고 감소시키는 작업 수행
//카운트 할당과 해제는 균형이 맞아야 함
//- alloc , retain 이 많을 경우는 Memory Leak 발생 
//- release 가 많을 경우 Dangling Pointer (허상, 고아) 발생
//- Dangling Pointer: 데이터 접근 불가 현상
/*ARC : 2011년 애플에서(WWDC) 만든 RC자동관리 RC 자동 관리 방식 (WWDC 2011 발표)
  - 컴파일러가 개발자를 대신하여 메모리 관리 코드를 적절한 위치에 자동으로 삽입
  - GC 처럼 런타임이 아닌 컴파일 단에서 처리 (Heap 에 대한 스캔 불필요 / 앱 일시 정지 현상 없음)
  - 메모리 관리 이슈를 줄이고 개발자가 코딩 자체에 집중할 수 있도록함*/
/*강한순환참조: 정상적으로 메모리에서 해제 되지 않고 계속 남아있는 현상
- 객체에 접근 가능한 모든 연결을 끊었음에도 순환 참조로 인해 활성화된 참조 카운트가 남아 있어 메모리 누수가 발생하는 현상
- 앱의 실행이 느려지거나 오동작 또는 오류를 발생시키는 원인이 됨 */
//weak: 강한순환참조를 방지하기 위해 사용하는 것으로, 참조카운트 증가를 발생시키지 않음.


class LocalScope {
    func doSomething() {}
    deinit {
        print("LocalScope is being deinitialized")
    }
}

class ClassProperty {
    func doSomething() {}
    deinit {
        print("ClassProperty is being deinitialized")
    }
}

class Application {
    var prop = ClassProperty()
    
    func allocateInstance() {
        let local = LocalScope()
        local.doSomething()
    }
    
    deinit {
        print("Application is being deinitialized")
    }
}


// Q. 아래의 코드 실행 시 출력되는 메시지는?

var app: Application? = Application() // Application 카운트 1 증가 -> ClassProperty 카운트 1 증가
app?.prop.doSomething()
app?.allocateInstance() // Application 내의 allocateInstance가 실행될때 잠깐 카운트 1 증가했다가 함수끝나는 대로 곧바로 카운트 0이 됨.



// Q. ClassProperty 객체의 deinit 메서드가 호출되려면 어떻게 할까요?

//답: app = nil


//: [Next](@next)
