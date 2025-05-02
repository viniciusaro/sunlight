import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:sunlight/sunlight.dart';

import 'clients/number_fact_client.dart';
import 'clients/number_fact_client.live.dart';
import 'reducer.analytics.dart';

part 'number_fact.freezed.dart';
part 'number_fact.g.dart';

@freezed
@KeyPathable()
abstract class NumberFactState with _$NumberFactState {
  factory NumberFactState({
    @Default(0) int count,
    @Default(false) bool isLoading,
    String? numberFact,
  }) = _NumberFactState;
}

@CaseKeyPathable()
sealed class NumberFactAction<
  DecrementButtonTapped,
  IncrementButtonTapped,
  NumberFactButtonTapped,
  NumberFactResponse extends String //
> {}

final class NumberFactFeature
    extends Feature<NumberFactState, NumberFactAction> {
  @override
  Reducer<NumberFactState, NumberFactAction> build() {
    return Reduce.combine([
      Reduce((state, action) {
        switch (action) {
          case NumberFactActionDecrementButtonTapped():
            state.mutate((s) => s.copyWith(count: s.count - 1));
            return Effect.none();

          case NumberFactActionIncrementButtonTapped():
            state.mutate((s) => s.copyWith(count: s.count + 1));
            return Effect.none();

          case NumberFactActionNumberFactButtonTapped():
            state.mutate((s) => s.copyWith(isLoading: true));
            return Effect.future(() async {
              final response = await numberFactClient.factFor(
                state.value.count,
              );
              return NumberFactActionEnum.numberFactResponse(response);
            });

          case NumberFactActionNumberFactResponse():
            state.mutate(
              (s) => s.copyWith(
                isLoading: false,
                numberFact: action.numberFactResponse,
              ),
            );
            return Effect.none();
        }
      }),
      Analytcs(),
    ]);
  }
}

class NumberFactWidget extends StatelessWidget {
  final Store<NumberFactState, NumberFactAction> store;

  const NumberFactWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (viewStore) {
        return Center(
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Count: ${viewStore.state.count}"),
              ElevatedButton(
                onPressed: () {
                  viewStore.send(NumberFactActionEnum.numberFactButtonTapped());
                },
                child: Text("Number Fact"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      viewStore.send(
                        NumberFactActionEnum.incrementButtonTapped(),
                      );
                    },
                    child: Text("+"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewStore.send(
                        NumberFactActionEnum.decrementButtonTapped(),
                      );
                    },
                    child: Text("-"),
                  ),
                ],
              ),
              if (viewStore.state.isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: CircularProgressIndicator(),
                )
              else if (viewStore.state.numberFact != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    "Fact: ${viewStore.state.numberFact}",
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  SunlightAnalytics.setup(
    boardClient: miroBoardClient(
      boardId: "boardId",
      token: "token",
    ),
  );

  analyticsClient = AnalyticsClient(
    logEvent: (event) {
      final parts = event.split(".");
      final id = parts.first.replaceAll("()", "").snakeCase;
      return SunlightAnalytics.log(name: id);
    },
  );

  numberFactClient = numbersApiNumberFactClient;

  runApp(
    MaterialApp(
      home: Sunlight(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: NumberFactWidget(
            store: Store(
              initialState: NumberFactState(),
              reducer: NumberFactFeature().debug(),
            ),
          ),
        ),
      ),
    ),
  );
}
